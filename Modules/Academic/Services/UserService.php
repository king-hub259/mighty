<?php

declare(strict_types=1);

namespace Modules\Academic\Services;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Hash;
use Intervention\Image\Facades\Image;
use Modules\Academic\Repositories\UserRepository;
use Modules\Authentication\Models\User;

class UserService
{
    public function __construct(
        private readonly UserRepository $userRepository
    ) {}

    public function getUsersAll(): Collection
    {
        return $this->userRepository->all();
    }

    public function getUsers(array $filter = [], int $perPage = 100): LengthAwarePaginator
    {
        return $this->userRepository->paginate($perPage, $filter);
    }

    public function findUserById(int $id): ?User
    {
        return $this->userRepository->show((int) $id);
    }

    public function createOrUpdateUser(array $data, $id = null): ?User
    {
        $data = $this->prepareForDB($data);

        if ($id === null) {
            $data['institute_id'] = get_institute_id();
            $data['branch_id'] = get_branch_id();

            return $this->userRepository->create($data);
        } else {
            $result = $this->userRepository->update($data, (int) $id);

            if ($result) {
                return $this->findUserById((int) $id);
            } else {
                return null;
            }
        }
    }

    public function deleteUserById(int $id)
    {
        return $this->userRepository->delete($id);
    }

    public function getUsersByExistType($userType): Collection
    {
        return User::where('user_type', '=', $userType)
            ->select('id', 'name', 'phone', 'user_type')
            ->get();
    }

    public function getUsersByExcludedParentAndStudent(): Collection
    {
        return User::where('user_type', '!=', 'Parent')
            ->where('user_type', '!=', 'Student')
            ->orderBy('id', 'ASC')->get();
    }

    public function prepareForDB(array $data): array
    {
        $preparedData[] = null;
        if (isset($data['email']) && ! empty($data['email'])) {
            $preparedData['email'] = $data['email'];
        }

        if (isset($data['phone']) && ! empty($data['phone'])) {
            $preparedData['phone'] = $data['phone'];
        }

        if (! empty($data['name'])) {
            $preparedData['name'] = $data['name'];
            $preparedData['user_type'] = $data['user_type'];
            $preparedData['role_id'] = $data['role_id'];
            $preparedData['facebook'] = $data['facebook'] ?? '#';
            $preparedData['twitter'] = $data['twitter'] ?? '#';
            $preparedData['linkedin'] = $data['linkedin'] ?? '#';
            $preparedData['google_plus'] = $data['google_plus'] ?? '#';
        } else {
            $preparedData['name'] = $data['first_name'];
            $preparedData['user_type'] = 'Student';
        }

        if (isset($data['password']) && ! empty($data['password'])) {
            $preparedData['password'] = Hash::make($data['password']);
        }

        // ✅ FIX: Check if 'image' is an uploaded file before processing
        if (isset($data['image']) && $data['image'] instanceof UploadedFile) {
            $image = $data['image'];
            $imageName = time().'.'.$image->getClientOriginalExtension();

            if ($data['user_type'] === 'Student') {
                $imagePath = 'uploads/students/'.$imageName;
            } else {
                $imagePath = 'uploads/users/'.$imageName;
            }

            // Save Image using Intervention Image
            Image::make($image)
                ->resize(200, 160)
                ->save(public_path($imagePath));

            $preparedData['image'] = $imagePath;
        } elseif (! empty($data['image']) && is_string($data['image'])) {
            // ✅ If image is already a string (existing file path), keep it
            $preparedData['image'] = $data['image'];
        }

        return $preparedData;
    }

    public function getUsersByExcludedType($userType): Collection
    {
        return User::select('id', 'name', 'user_type')
            ->where('user_type', '!=', $userType)
            ->where('user_type', '!=', 'Admin')
            ->with('userPayroll')
            ->get();
    }
}
