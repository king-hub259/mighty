<?php

use App\Enums\VoucherType;
use App\Services\SmsService;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Storage;
use Modules\Academic\Models\Event;
use Modules\Academic\Models\Notice;
use Modules\Academic\Models\Signature;
use Modules\Authentication\Models\User;
use Modules\SystemConfiguration\Models\Setting;

// Get the function for user Institute ID
if (! function_exists('get_institute_id')) {
    function get_institute_id()
    {
        return auth()->check() ? auth()->user()->institute_id : null;
    }
}

// Get the function for user Branch ID
if (! function_exists('get_branch_id')) {
    function get_branch_id()
    {
        return auth()->check() ? auth()->user()->branch_id : null;
    }
}

if (! function_exists('_lang')) {
    function _lang($string = '')
    {
        $targetLang = Session::has('locale') && ! empty(Session::get('locale'))
            ? Session::get('locale')
            : (! empty(get_option('language')) ? get_option('language') : 'en');

        $json = [];
        if (file_exists(lang_path()."/$targetLang.json")) {
            $json = json_decode(file_get_contents(lang_path()."/$targetLang.json"), true);
        }

        return ! empty($json[$string]) ? $json[$string] : $string;
    }
}

if (! function_exists('load_language')) {
    function load_language($active = '')
    {
        $path = lang_path();
        $files = scandir($path);
        $options = '';

        foreach ($files as $file) {
            $name = pathinfo($file, PATHINFO_FILENAME);
            if ($name == '.' || $name == '' || $name == 'language') {
                continue;
            }

            $selected = '';
            if ($active == $name) {
                $selected = 'selected';
            } else {
                $selected = '';
            }

            $options .= "<option value='$name' $selected>".ucwords($name).'</option>';
        }
        echo $options;
    }
}

if (! function_exists('startsWith')) {
    function startsWith($haystack, $needle)
    {
        $length = strlen($needle);

        return substr($haystack, 0, $length) === $needle;
    }
}

if (! function_exists('create_option')) {
    function create_option($table, $value, $display, $selected = '', $where = null, $type = null)
    {
        $options = '';
        $condition = '';
        if ($where != null) {
            $condition .= 'WHERE ';
            foreach ($where as $key => $v) {
                $condition .= $key."'".$v."' ";
            }
        }

        if ($type == 'subject') {
            $query = DB::select("SELECT * FROM $table $condition");
            $options .= "<option value='' selected='true'>Select Value</option>";
            foreach ($query as $d) {
                if ($selected != '' && $selected == $d->$value) {
                    $options .= "<option value='".$d->$value."' selected='true'>".ucwords($d->$display).'-'.$d->subject_code.'</option>';
                } else {
                    $options .= "<option value='".$d->$value."'>".ucwords($d->$display).'-'.$d->subject_code.'</option>';
                }
            }
        } else {
            $query = DB::select("SELECT $value, $display FROM $table $condition");
            $options .= "<option value='' selected='true'>Select Value</option>";
            foreach ($query as $d) {
                if ($selected != '' && $selected == $d->$value) {
                    $options .= "<option value='".$d->$value."' selected='true'>".ucwords($d->$display).'</option>';
                } else {
                    $options .= "<option value='".$d->$value."'>".ucwords($d->$display).'</option>';
                }
            }
        }

        echo $options;
    }
}

if (! function_exists('get_table')) {
    function get_table($table, $where = null)
    {
        $condition = '';
        if ($where != null) {
            $condition .= 'WHERE ';
            foreach ($where as $key => $v) {
                $condition .= $key."'".$v."' ";
            }
        }
        $query = DB::select("SELECT * FROM $table $condition");

        return $query;
    }
}

if (! function_exists('get_logo_file_path')) {
    function get_logo_file_path()
    {
        $logo = get_option('logo');
        if ($logo == '') {
            return 'uploads/logo.png';
        }

        return "uploads/$logo";
    }
}

if (! function_exists('get_logo')) {
    function get_logo()
    {
        return asset(get_logo_file_path());
    }
}

if (! function_exists('sql_escape')) {
    function sql_escape($unsafe_str)
    {

        $unsafe_str = stripslashes($unsafe_str);

        return $escaped_str = str_replace("'", '', $unsafe_str);
    }
}

if (! function_exists('get_option')) {
    function get_option($name)
    {
        try {
            // Check if the database connection is valid
            DB::connection()->getPdo();

            // Check if the 'settings' table exists
            if (! Schema::hasTable('settings')) {
                return ''; // Return empty or default value if table doesn't exist
            }

            // Retrieve the option from the settings table
            $setting = DB::table('settings')->where('name', $name)->first();

            return $setting ? (int) $setting->value : ''; // Return the value or empty string
        } catch (\Exception $e) {
            // If database connection fails, return an empty string or log the error
            return '';
        }
    }
}

if (! function_exists('timezone_list')) {

    function timezone_list()
    {
        $zones_array = [];
        $timestamp = time();
        foreach (timezone_identifiers_list() as $key => $zone) {
            date_default_timezone_set($zone);
            $zones_array[$key]['ZONE'] = $zone;
            $zones_array[$key]['GMT'] = 'UTC/GMT '.date('P', $timestamp);
        }

        return $zones_array;
    }
}

if (! function_exists('create_timezone_option')) {

    function create_timezone_option($old = '')
    {
        $option = '';
        $timestamp = time();
        foreach (timezone_identifiers_list() as $key => $zone) {
            date_default_timezone_set($zone);
            $selected = $old == $zone ? 'selected' : '';
            $option .= '<option value="'.$zone.'"'.$selected.'>'.'GMT '.date('P', $timestamp).' '.$zone.'</option>';
        }
        echo $option;
    }
}

if (! function_exists('generate_select')) {
    function generate_select(
        $name,
        $options = [],
        $label = null,
        $selected = null,
        $required = false,
        $emptyLabel = '--Select--',
        $class = 'form-select form-select-sm form-select-solid',
        $id = null,
        $onchange = null,
        bool $enableRequiredMark = true,
        $isMultiple = false
    ) {
        $select = '';
        $requiredText = '';

        // If request is for backend
        $requiredText = ($required && $enableRequiredMark) ? "<span class='text-danger'>*</span>" : '';

        if (! empty($label)) {
            $select = "<label class='label-control my-2'>$label ".$requiredText.'</label>';
        }

        if ($isMultiple) {
            $name = $name.'[]';
        }

        $select .= "<select name='$name' "
            .(! empty($id) ? "id='$id' " : '')
            .(! empty($onchange) ? "onchange='$onchange' " : '')
            ."class='$class' "
            .($required ? 'required ' : '')
            .($isMultiple ? 'multiple ' : '')
            ."data-control='select2'>";

        if (! empty($emptyLabel)) {
            $select .= "<option value='' disabled>$emptyLabel</option>";
        }

        foreach ($options as $key => $value) {
            $select .= "<option value='$key' ".($selected == $key ? 'selected' : '').">$value</option>";
        }

        $select = $select.'</select>';

        return $select;
    }
}

if (! function_exists('get_subject_types')) {
    function get_subject_types()
    {
        return [
            'Compulsory' => _lang('Compulsory'),
            'Optional' => _lang('Optional'),
        ];
    }
}

if (! function_exists('get_section_name')) {
    function get_section_name($id)
    {
        $class = DB::table('sections')->where('id', $id)->get();
        if (! $class->isEmpty()) {
            return $class[0]->section_name;
        }

        return '';
    }
}

if (! function_exists('get_subject_name')) {
    function get_subject_name($id)
    {
        $class = DB::table('subjects')->where('id', $id)->get();
        if (! $class->isEmpty()) {
            return $class[0]->subject_name;
        }

        return '';
    }
}

if (! function_exists('get_subject_all_types')) {
    function get_subject_all_types()
    {
        return [
            'All' => _lang('All Groups'),
            'Compulsory' => _lang('Compulsory'),
            'Elective' => _lang('Elective'),
            'Optional' => _lang('Optional'),
            'Elective_Optional' => _lang('Elective & Optional Both'),
        ];
    }
}

if (! function_exists('get_blood_groups')) {
    function get_blood_groups(): array
    {
        return [
            'A+' => 'A+',
            'A-' => 'A-',
            'B+' => 'B+',
            'B-' => 'B-',
            'O+' => 'O+',
            'O-' => 'O-',
            'AB+' => 'AB+',
            'AB-' => 'AB-',
        ];
    }
}

if (! function_exists('get_blood_groups_select')) {
    function get_blood_groups_select($inputName, $label, $selected = '', $required = false, $class = 'form-control')
    {
        return generate_select($inputName, get_blood_groups(), $label, $selected, $required, _lang('--Select Group--'), $class);
    }
}

if (! function_exists('get_academic_year')) {
    function get_academic_year($id = '')
    {
        if ($id == '') {
            $id = get_option('academic_year');
        }
        $query = DB::table('academic_years')->where('id', $id)->get();
        if (! $query->isEmpty()) {
            return $query[0]->id;
        }

        return '';
    }
}

if (! function_exists('current_year')) {
    function current_year()
    {
        $currentYear = Carbon::now()->year;

        return $currentYear;
    }
}

if (! function_exists('get_class_name')) {
    function get_class_name($id)
    {
        $class = DB::table('classes')->where('id', $id)->get();
        if (! $class->isEmpty()) {
            return $class[0]->class_name;
        }

        return '';
    }
}

if (! function_exists('get_accounting_types')) {
    function get_accounting_types(?string $key = null): array|string
    {
        $types = [
            VoucherType::PAYMENT => _lang('Payment'),
            VoucherType::RECEIPT => _lang('Receipt'),
            VoucherType::CONTRA => _lang('Contra'),
            VoucherType::FUND_TRANSFER => _lang('Fund Transfer'),
            VoucherType::JOURNAL => _lang('Journal'),
        ];

        if ($key) {
            return $types[$key] ?? '';
        }

        return $types;
    }
}

if (! function_exists('get_old_value')) {
    function get_old_value($student, $key = '')
    {
        if (empty($student)) {
            return old($key);
        }

        return $student->$key;
    }
}

if (! function_exists('get_parent_id')) {
    function get_parent_id()
    {
        $user_id = Auth::user()->id;
        $parent = DB::select("SELECT id FROM parent_models
		WHERE user_id='$user_id'");

        return $parent[0]->id;
    }
}

if (! function_exists('get_authenticated_parent_student_id')) {
    function get_authenticated_parent_student_id()
    {
        // Get the authenticated user's ID
        $user_id = Auth::user()->id;

        // Fetch the student_id from the parent_models table where user_id matches
        $student_id = DB::table('parent_models')
            ->where('user_id', $user_id)
            ->value('student_id');  // Fetch the student_id directly

        // Return the student_id or null if not found
        return $student_id ? $student_id : null;
    }
}

if (! function_exists('get_student_id')) {
    function get_student_id()
    {
        $user_id = Auth::user()->id;
        $student = DB::select("SELECT id FROM students
		WHERE user_id='$user_id'");

        return $student[0]->id;
    }
}

if (! function_exists('get_student_name')) {
    function get_student_name($student_id)
    {
        $student = DB::select("SELECT first_name,last_name FROM students
		WHERE id='$student_id'");

        return $student[0]->first_name;
    }
}

if (! function_exists('get_teacher_id')) {
    function get_teacher_id()
    {
        $user_id = Auth::user()->id;
        $teacher = DB::select("SELECT id FROM teachers
		WHERE user_id='$user_id'");

        return $teacher[0]->id;
    }
}

if (! function_exists('format_currency')) {
    function format_currency($amount)
    {
        // Number formatter with en_US locale.
        $fmt = new NumberFormatter('en_US', NumberFormatter::DECIMAL);
        $formattedAmount = $fmt->format($amount);

        // Append the currency symbol manually.
        return '৳'.$formattedAmount;
    }
}

if (! function_exists('convert_amount_to_words')) {
    function convert_amount_to_words($number)
    {
        $f = new NumberFormatter('en', NumberFormatter::SPELLOUT);

        return ucfirst($f->format($number)).' Taka Only';
    }
}

if (! function_exists('object_to_string')) {
    function object_to_string($object, $col, $quote = false)
    {
        $string = '';
        foreach ($object as $data) {
            if ($quote == true) {
                $string .= "'".$data->$col."', ";
            } else {
                $string .= $data->$col.', ';
            }
        }
        $string = substr_replace($string, '', -2);

        return $string;
    }
}

if (! function_exists('printSignature')) {
    function printSignature($id = 1)
    {
        $signature = Signature::find($id);
        if ($signature && $signature->image) {
            $imagePath = asset('uploads/'.$signature->image);

            return "<img class=\"printSignature\" src=\"{$imagePath}\" height=\"70px\" width=\"250px\" alt=\"\">";
        }

        return '';
    }
}

if (! function_exists('user_count')) {
    function user_count($user_type)
    {
        $count = User::where('institute_id', get_institute_id())
            ->where('branch_id', get_branch_id())
            ->where('user_type', $user_type)
            ->selectRaw('COUNT(id) as total')
            ->first()->total;

        return $count;
    }
}

if (! function_exists('get_notices')) {
    function get_notices($user_type = 'Website', $limit = 5)
    {
        $notices = Notice::join('user_notices', 'notices.id', 'user_notices.notice_id')
            ->select('notices.*')
            ->where('user_notices.user_type', $user_type)
            ->where('notices.institute_id', get_institute_id())
            ->where('notices.branch_id', get_branch_id())
            ->orderBy('notices.id', 'desc')
            ->limit($limit)
            ->get();

        return $notices;
    }
}

if (! function_exists('get_events')) {
    function get_events($limit = 5)
    {
        $events = Event::limit($limit)
            ->orderBy('id', 'desc')->where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->get();

        return $events;
    }
}

if (! function_exists('fileUploader')) {
    function fileUploader(string $dir, string $format, $image = null, $oldImage = null)
    {
        if ($image == null) {
            return $oldImage ?? 'def.png';
        }

        // Delete old image(s) if exist
        if (! empty($oldImage)) {
            if (is_array($oldImage)) {
                foreach ($oldImage as $file) {
                    Storage::disk('public')->delete($dir.$file);
                }
            } elseif (is_string($oldImage)) {
                Storage::disk('public')->delete($dir.$oldImage);
            }
        }

        // Generate unique file name
        $imageName = Carbon::now()->toDateString().'-'.uniqid().'.'.$format;

        // Ensure directory exists
        if (! Storage::disk('public')->exists($dir)) {
            Storage::disk('public')->makeDirectory($dir);
        }

        // Store the uploaded file
        if ($image instanceof \Illuminate\Http\UploadedFile) {
            $image->storeAs($dir, $imageName, 'public');
        } else {
            throw new \Exception('Invalid file type provided for upload.');
        }

        return $imageName;
    }
}

if (! function_exists('fileRemover')) {
    function fileRemover(string $dir, $image)
    {
        if (! isset($image)) {
            return true;
        }

        if (Storage::disk('public')->exists($dir.$image)) {
            Storage::disk('public')->delete($dir.$image);
        }

        return true;
    }
}

if (! function_exists('sent_sms')) {
    function sent_sms($phone, $message)
    {
        try {
            $smsService = new SmsService;

            return $smsService->sendSMS($phone, $message);
        } catch (Exception $e) {
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
}

if (! function_exists('configSettings')) {
    function configSettings($key, $settingsType)
    {
        try {
            $config = DB::table('settings')->where('key_name', $key)
                ->where('settings_type', $settingsType)->first();
        } catch (Exception $exception) {
            return null;
        }

        return (isset($config)) ? $config : null;
    }
}

if (! function_exists('businessConfig')) {
    function businessConfig($key, $settingsType = null)
    {
        try {
            $config = Setting::query()
                ->where('key_name', $key)
                ->when($settingsType, function ($query) use ($settingsType) {
                    $query->where('settings_type', $settingsType);
                })
                ->first();
        } catch (Exception $exception) {
            return null;
        }

        return (isset($config)) ? $config : null;
    }
}
