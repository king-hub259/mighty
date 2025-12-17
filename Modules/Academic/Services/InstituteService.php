<?php

declare(strict_types=1);

namespace Modules\Academic\Services;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Modules\Academic\Repositories\InstituteRepository;
use Modules\Authentication\Models\Institute;

class InstituteService
{
    public function __construct(
        private readonly InstituteRepository $instituteRepository
    ) {}

    public function getInstitutes(array $filter = [], int $perPage = 100): LengthAwarePaginator
    {
        return $this->instituteRepository->paginate($perPage, $filter);
    }

    public function findInstituteById(int $id): ?Institute
    {
        return $this->instituteRepository->show((int) $id);
    }

    public function createInstitute(array $data): ?Institute
    {
        return $this->instituteRepository->create($data);
    }

    public function updateInstitute(array $data, int $id): mixed
    {
        return $this->instituteRepository->update($data, $id);
    }

    public function deleteInstituteById(int $id): void
    {
        return $this->instituteRepository->delete($id);
    }
}
