<?php

declare(strict_types=1);

namespace Modules\Academic\Services;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Modules\Academic\Models\StudentSession;
use Modules\Academic\Repositories\StudentSessionRepository;

class StudentSessionService
{
    public function __construct(
        private readonly StudentSessionRepository $studentSessionRepository
    ) {}

    public function getAllStudentSessions()
    {
        return $this->studentSessionRepository->all();
    }

    public function getStudentSessions(array $filter = [], int $perPage = 100): LengthAwarePaginator
    {
        return $this->studentSessionRepository->paginate($perPage, $filter);
    }

    public function findStudentSessionById(int $id): ?StudentSession
    {
        return $this->studentSessionRepository->show((int) $id);
    }

    public function createStudentSession(array $data): ?StudentSession
    {
        $data['institute_id'] = get_institute_id();
        $data['branch_id'] = get_branch_id();

        return $this->studentSessionRepository->create($data);
    }

    public function updateStudentSession(array $data, int $id): mixed
    {
        return $this->studentSessionRepository->update($data, $id);
    }

    public function findStudentSessionByStudentId(int $id): ?StudentSession
    {
        return $this->studentSessionRepository->findStudentSessionByStudentId($id);
    }

    public function deleteStudentSessionById(int $id): int
    {
        return $this->studentSessionRepository->delete($id);
    }

    public function getStudentByClassId(int $id): Collection
    {
        return $this->studentSessionRepository->studentByClassId($id);
    }

    public function deleteStudentSessionByRollNo(int $studentId, int $rollNo)
    {
        return $this->studentSessionRepository->deleteByRoll($studentId, $rollNo);
    }
}
