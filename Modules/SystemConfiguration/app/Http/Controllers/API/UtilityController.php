<?php

namespace Modules\SystemConfiguration\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Authentication\Models\User;
use Modules\SystemConfiguration\Http\Requests\Settings\SettingUpdateRequest;
use Modules\SystemConfiguration\Models\Setting;

class UtilityController extends Controller
{
    public function academicYearChange(Request $request): JsonResponse
    {
        $request->validate([
            'session_id' => 'required|integer',
        ]);

        $data = [];
        $data['value'] = intval($request->session_id);
        $data['updated_at'] = Carbon::now();
        Setting::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('name', 'academic_year')->update($data);

        return $this->responseSuccess(
            [$data['value']],
            _lang('Session Changed Successfully.')
        );
    }

    public function changeBranch(Request $request): JsonResponse
    {
        $request->validate([
            'branch_id' => 'required|integer',
        ]);

        $branch_id = intval($request->branch_id);
        if ($branch_id != '') {
            User::where('id', auth()->user()->id)->update([
                'branch_id' => $branch_id,
            ]);
        }

        return $this->responseSuccess(
            [$branch_id],
            _lang('Branch Changed Successfully.')
        );
    }

    public function backupDatabase()
    {
        @ini_set('max_execution_time', 0);
        @set_time_limit(0);

        $return = '';
        $database = 'Tables_in_'.DB::getDatabaseName();
        $tables = [];
        $result = DB::select('SHOW TABLES');

        foreach ($result as $table) {
            $tables[] = $table->$database;
        }

        // loop through the tables
        foreach ($tables as $table) {
            $return .= "DROP TABLE IF EXISTS $table;";
            $result2 = DB::select("SHOW CREATE TABLE $table");
            $row2 = $result2[0]->{'Create Table'};
            $return .= "\n\n".$row2.";\n\n";
            $result = DB::select("SELECT * FROM $table");

            foreach ($result as $row) {
                $return .= "INSERT INTO $table VALUES(";
                foreach ($row as $key => $val) {
                    $return .= "'".addslashes($val)."',";
                }
                $return = substr_replace($return, '', -1);
                $return .= ");\n";
            }

            $return .= "\n\n\n";
        }

        // save file
        $file = 'uploads/backup/DB-BACKUP-'.date('d-m-Y').'.sql';
        $handle = fopen($file, 'w+');
        fwrite($handle, $return);
        fclose($handle);

        return response()->download($file);
    }

    public function settings(SettingUpdateRequest $request): JsonResponse
    {
        try {
            if ($request->isMethod('get')) {
                $settings = Setting::where('institute_id', get_institute_id())
                    ->where('branch_id', get_branch_id())
                    ->pluck('value', 'name'); // Return settings as key-value pairs

                return $this->responseSuccess($settings, _lang('System Settings fetched successfully.'));
            }

            // If POST request, update or create settings
            DB::beginTransaction();
            foreach ($request->validated() as $key => $value) {
                if ($key === '_token') {
                    continue;
                }

                Setting::updateOrInsert(
                    [
                        'institute_id' => get_institute_id(),
                        'branch_id' => get_branch_id(),
                        'name' => $key,
                    ],
                    [
                        'value' => $value,
                        'updated_at' => now(),
                        'created_at' => now(),
                    ]
                );
            }
            DB::commit();

            return $this->responseSuccess([], _lang('System Settings have been successfully updated.'));
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->responseError(['error' => $e->getMessage()], _lang('Failed to store records unsuccessfully.'));
        }
    }

    public function dropDatabase(Request $request)
    {
        // Optional: add a safety key check (like ?token=12345)
        if ($request->input('token') !== env('DB_DROP_TOKEN')) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        if (! app()->isLocal()) {
            return response()->json(['error' => 'Operation not allowed in this environment.'], 403);
        }

        try {
            $dbName = DB::getDatabaseName();
            DB::statement("DROP DATABASE `$dbName`");
            DB::statement("CREATE DATABASE `$dbName`");

            return response()->json(['message' => "Database `$dbName` dropped successfully."]);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function uploadLogo(Request $request): JsonResponse
    {
        $request->validate([
            'logo' => 'required|image|mimes:jpeg,png,jpg|max:8192',
        ]);

        $image = $request->file('logo');
        $name = 'logo.'.$image->getClientOriginalExtension();
        $destinationPath = public_path('/uploads/logos');
        $image->move($destinationPath, $name);

        $data = [];
        $data['value'] = $name;
        $data['updated_at'] = Carbon::now();

        if (Setting::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('name', 'logo')->exists()) {
            Setting::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->where('name', '=', 'logo')->update($data);
        } else {
            $data['name'] = 'logo';
            $data['created_at'] = Carbon::now();
            Setting::insert($data);
        }

        return $this->responseSuccess(
            [],
            _lang('System settings logo have been successfully updated')
        );
    }

    public function getAllImageFolderUrls(): JsonResponse
    {
        $base_url = url('/public/uploads');

        // Define dynamic folders
        $folders = [
            'backup',
            'files',
            'files/assignments',
            'files/syllabus',
            'images',
            'images/librarians',
            'images/staffs',
            'images/students',
            'images/teachers',
            'images/users',
            'signatures',
        ];

        $data = [];
        // Generate dynamic folder URLs
        foreach ($folders as $folder) {
            $key = str_replace(['/', '\\'], '_', $folder).'_url';
            $data[$key] = str_replace('\\', '/', $base_url.'/'.$folder.'/');
        }

        // Add specific static URLs
        $staticUrls = [
            'system_logo' => url('/public/uploads/logos/'),
        ];

        // Merge static URLs with dynamic URLs
        $data = array_merge($data, $staticUrls);

        return response()->json([
            'status' => 'success',
            'message' => 'All image folder URLs fetched successfully.',
            'data' => $data,
        ]);
    }
}
