<?php

declare(strict_types=1);

namespace Modules\Academic\Repositories;

use App\Interfaces\BaseRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Modules\Academic\Models\StudentSession;

class StudentSessionRepository implements BaseRepositoryInterface
{
    public function all(): Collection
    {
        return StudentSession::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->get();
    }

    public function paginate(int $perPage = 100, array $filter = []): LengthAwarePaginator
    {
        $query = StudentSession::query();

        return $query->where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->paginate($perPage);
    }

    public function create(array $data): ?StudentSession
    {
        return StudentSession::create($data);
    }

    public function update(array $data, int $id): ?bool
    {
        $session = $this->show((int) $id);

        if (! $session) {
            return null;
        }

        return $session->update($data);
    }

    public function findStudentSessionByStudentId(int $id): ?StudentSession
    {
        return StudentSession::where('student_id', $id)->first();
    }

    public function delete(int $id): int
    {
        return StudentSession::destroy($id);
    }

    public function show(int $id): ?StudentSession
    {
        return StudentSession::with('student')->find($id);
    }

    public function studentByClassId(int $id): Collection
    {
        return StudentSession::where('class_id', $id)->get();
    }

    public function deleteByRoll(int $studentId, int $rollNo): mixed
    {
        $studentSession = StudentSession::where('student_id', $studentId)->where('roll', $rollNo)->first();

        return $studentSession->delete();
    }
}
