<?php

namespace App\Http\Controllers\WEB;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Nwidart\Modules\Facades\Module;
use ZipArchive;

class InstallController extends Controller
{
    public function index()
    {
        Artisan::call('cache:clear');
        Artisan::call('config:clear');
        Artisan::call('key:generate');
        Artisan::call('view:clear');

        return view('install.start');
    }

    public function requirements()
    {
        $requirements = [
            'PHP Version (^8.2)' => version_compare(phpversion(), '^8.2', '>='),
            'OpenSSL Extension' => extension_loaded('openssl'),
            'PDO Extension' => extension_loaded('PDO'),
            'PDO MySQL Extension' => extension_loaded('pdo_mysql'),
            'Mbstring Extension' => extension_loaded('mbstring'),
            'Tokenizer Extension' => extension_loaded('tokenizer'),
            'GD Extension' => extension_loaded('gd'),
            'Fileinfo Extension' => extension_loaded('fileinfo'),
        ];
        $next = true;
        foreach ($requirements as $key) {
            if ($key == false) {
                $next = false;
            }
        }

        return view('install.requirements', compact('requirements', 'next'));
    }

    public function keyWorld()
    {
        $next = true;

        return view('install.codeniche_file', compact('next'));
    }

    public function step5(Request $request)
    {
        return view('install.database');
    }

    public function permissions()
    {
        $permissions = [
            'storage/app' => is_writable(storage_path('app')),
            'storage/framework/cache' => is_writable(storage_path('framework/cache')),
            'storage/framework/sessions' => is_writable(storage_path('framework/sessions')),
            'storage/framework/views' => is_writable(storage_path('framework/views')),
            'storage/logs' => is_writable(storage_path('logs')),
            'storage' => is_writable(storage_path('')),
            'bootstrap/cache' => is_writable(base_path('bootstrap/cache')),
        ];
        $next = true;
        foreach ($permissions as $key) {
            if ($key == false) {
                $next = false;
            }
        }

        return view('install.permissions', compact('permissions', 'next'));
    }

    public function database(Request $request)
    {
        if ($request->isMethod('post')) {
            $credentials = [
                'software_name' => $request->software_name,
                'host' => $request->host,
                'username' => $request->username,
                'password' => $request->password,
                'name' => $request->name,
                'port' => $request->port,
            ];

            // Step 1: Update the .env file
            $this->updateEnvFile($credentials);

            // Step 3: Test the Database Connection
            try {
                DB::purge('mysql'); // Reset connection
                DB::reconnect('mysql'); // Reconnect with new settings
                DB::connection()->getPdo(); // Attempt to connect

                // Step 4: Check if Database Exists
                if (! DB::select('SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = ?', [$credentials['name']])) {
                    return redirect()->back()->withErrors(['error' => __('The specified database does not exist.')]);
                }

                return redirect('install/installation');
            } catch (Exception $e) {
                return redirect()->back()->withErrors(['error' => 'Database connection failed: '.$e->getMessage()]);
            }
        }

        return view('install.database');
    }

    private function updateEnvFile(array $credentials)
    {
        $path = base_path('.env');

        if (file_exists($path)) {
            $envContent = file_get_contents($path);

            $envContent = preg_replace('/^APP_NAME=.*/m', 'APP_NAME="'.$credentials['software_name'].'"', $envContent);
            $envContent = preg_replace('/^DB_HOST=.*/m', 'DB_HOST='.$credentials['host'], $envContent);
            $envContent = preg_replace('/^DB_DATABASE=.*/m', 'DB_DATABASE='.$credentials['name'], $envContent);
            $envContent = preg_replace('/^DB_USERNAME=.*/m', 'DB_USERNAME='.$credentials['username'], $envContent);
            $envContent = preg_replace('/^DB_PASSWORD=.*/m', 'DB_PASSWORD='.$credentials['password'], $envContent);
            $envContent = preg_replace('/^DB_PORT=.*/m', 'DB_PORT='.$credentials['port'], $envContent);

            file_put_contents($path, $envContent);
        }
    }

    public function installation(Request $request)
    {
        if ($request->isMethod('post')) {
            try {
                Artisan::call('view:clear');
                Artisan::call('cache:clear');
                Artisan::call('config:clear');
                Artisan::call('migrate:fresh');
                Artisan::call('db:seed');
                // Seed all modules
                $modules = Module::allEnabled(); // Fetch all enabled modules
                foreach ($modules as $module) {
                    Artisan::call('module:seed', ['module' => $module->getName()]);
                }

                // Insert the personal access client into the oauth_clients table
                $clientId = (string) Str::uuid(); // Generate a unique UUID for the client ID
                $clientSecret = Str::random(40); // Generate a secure random secret
                DB::table('oauth_clients')->insert([
                    'id' => $clientId,
                    'user_id' => null,
                    'name' => 'Personal Access Client',
                    'secret' => $clientSecret,
                    'provider' => null,
                    'redirect' => 'http://localhost',
                    'personal_access_client' => true,
                    'password_client' => false,
                    'revoked' => false,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                // Insert the corresponding record into the oauth_personal_access_clients table
                DB::table('oauth_personal_access_clients')->insert([
                    'id' => 1, // Adjust ID as needed
                    'client_id' => $clientId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                file_put_contents(storage_path('mightySchool'), 'Welcome to MightySchool Software');

                // 🔥 Delete migration and seeder files
                $this->deleteInstallationFiles();

                return redirect('install/complete');
            } catch (Exception $e) {
                return redirect()->back();
            }
        }

        return view('install.installation');
    }

    public function complete()
    {
        Artisan::call('view:clear');
        Artisan::call('cache:clear');
        Artisan::call('config:clear');

        return view('install.complete');
    }

    public function validateInput(Request $request)
    {
        // Basic local validation for required fields
        $validator = Validator::make($request->all(), [
            'purchase_key' => 'required|string',
            'username' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'errors' => $validator->errors(),
            ]);
        }

        $domain = $request->getHost(); // Get current domain
        $purchaseKey = $request->purchase_key;
        $userName = $request->username;

        try {
            $domainCheckUrl = config('install.codeniche.domain_register_check');

            $response = Http::post($domainCheckUrl, [
                'purchase_key' => $purchaseKey,
                'domain' => $domain,
                'username' => $userName,
            ]);

            if ($response->successful()) {
                return response()->json([
                    'status' => 'success',
                    'message' => $response['message'] ?? 'Domain successfully validated.',
                ]);
            } else {
                $errorMessage = $response->json()['message'] ?? 'Validation failed.';

                return response()->json([
                    'status' => 'error',
                    'message' => $errorMessage,
                ], $response->status());
            }
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'An unexpected error occurred. Please try again later.',
            ], 500);
        }
    }

    /**
     * Delete all migration and seeder files permanently.
     */
    private function deleteInstallationFiles()
    {
        // Delete Laravel migrations
        $migrationFiles = glob(database_path('migrations/*.php'));
        foreach ($migrationFiles as $file) {
            @unlink($file);
        }

        // Delete Laravel seeders
        $seederFiles = glob(database_path('seeders/*.php'));
        foreach ($seederFiles as $file) {
            @unlink($file);
        }

        // Optional: Delete module-specific migration and seeder files
        foreach (Module::all() as $module) {
            $moduleMigrationPath = module_path($module->getName()).'/Database/Migrations';
            $moduleSeederPath = module_path($module->getName()).'/Database/Seeders';

            $moduleMigrations = glob($moduleMigrationPath.'/*.php');
            foreach ($moduleMigrations as $file) {
                @unlink($file);
            }

            $moduleSeeders = glob($moduleSeederPath.'/*.php');
            foreach ($moduleSeeders as $file) {
                @unlink($file);
            }
        }
    }

    public function upgradeIndex(Request $request)
    {
        return view('upgrade');
    }

    public function uploadStore(Request $request)
    {
        $request->validate([
            'upgrade_zip' => 'required|file|mimes:zip',
        ]);

        $file = $request->file('upgrade_zip');
        $zip = new ZipArchive;

        $filePath = storage_path('app/temp_upgrade.zip');
        $file->move(storage_path(), 'temp_upgrade.zip');

        if ($zip->open($filePath) === true) {
            $zip->extractTo(base_path()); // ⚠️ this will overwrite existing files
            $zip->close();
            File::delete($filePath);

            return back()->with('success', 'Upgrade applied successfully!');
        }

        return back()->with('error', 'Failed to extract zip file.');
    }
}
