<?php

namespace Modules\Authentication\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Modules\Authentication\Http\Requests\Auth\RegisterRequest;
use Modules\Authentication\Http\Requests\ProfileUpdateRequest;
use Modules\Authentication\Models\User;

class AuthController extends Controller
{
    public function user(Request $request): JsonResponse
    {
        try {
            $user = User::where('id', Auth::id())->first();

            if ($user) {
                $permissions = $user->role?->permissions->pluck('name')->toArray() ?? []; // Convert permissions to an array

                $user = [
                    'id' => $user->id,
                    'institute_id' => $user->institute_id,
                    'branch_id' => $user->branch_id,
                    'name' => $user->name,
                    'username' => $user->username,
                    'email' => $user->email,
                    'phone' => $user->phone,
                    'image' => asset('uploads/images/'.$user->image),
                    'role' => $user->role?->name ?? 'no-role-assign',
                    'status' => $user->status,
                    'permissions' => $permissions,
                    'email_verified_at' => $user->email_verified_at,
                    'created_at' => $user->created_at,
                    'deleted_at' => $user->deleted_at,
                ];

                return $this->responseSuccess($user, 'Profile fetched successfully.');
            } else {
                return $this->responseError([], 'Profile not found.');
            }
        } catch (Exception $e) {
            return $this->responseError([], 'An error occurred while fetching the profile.');
        }
    }

    public function login(LoginRequest $request): JsonResponse
    {
        $user = User::where('email', $request->email)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            return $this->responseError([], 'The provided credentials are incorrect..');
        }

        $accessToken = $user->createToken('app')->accessToken;

        return $this->responseSuccess([
            'user' => $user,
            'access_token' => $accessToken,
        ]);
    }

    public function register(RegisterRequest $request): JsonResponse
    {
        User::create([
            'name' => $request->name,
            'username' => Str::slug($request->name),
            'email' => $request->email,
            'phone' => $request->phone,
            'email_verified_at' => Carbon::now(),
            'password' => Hash::make($request->password),

        ]);

        return $this->responseSuccess([], 'Registration Successfully Done.');
    }

    public function profileUpdate(ProfileUpdateRequest $request): JsonResponse
    {
        $request->user()->fill($request->validated());

        if ($request->user()->isDirty('email')) {
            $request->user()->email_verified_at = null;
        }

        $request->user()->save();

        return $this->responseSuccess([], 'Profile Update Successfully Done.');
    }

    public function changePassword(Request $request): JsonResponse
    {
        $validated = $request->validateWithBag('updatePassword', [
            'current_password' => ['required', 'current_password'],
            'password' => ['required', 'confirmed'],
        ]);

        $request->user()->update([
            'password' => Hash::make($validated['password']),
        ]);

        return $this->responseSuccess([], 'Password Changes Successfully Done.');
    }

    public function logout(Request $request)
    {
        try {
            $result = $request->user()->token()->revoke();
            if ($result) {
                return $this->responseSuccess([], 'Logout Success');
            }
        } catch (Exception $e) {
            return $this->responseError([], 'Logout Failed');
        }
    }
}
