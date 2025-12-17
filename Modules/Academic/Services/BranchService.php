<?php

declare(strict_types=1);

namespace Modules\Academic\Services;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Modules\Academic\Repositories\BranchRepository;
use Modules\Authentication\Models\Branch;

class BranchService
{
    public function __construct(
        private readonly BranchRepository $branchRepository
    ) {}

    public function getBranches(array $filter = [], int $perPage = 100): LengthAwarePaginator
    {
        return $this->branchRepository->paginate($perPage, $filter);
    }

    public function findBranchById(int $id): ?Branch
    {
        return $this->branchRepository->show((int) $id);
    }

    public function createBranch(array $data): ?Branch
    {
        $data['institute_id'] = get_institute_id();

        return $this->branchRepository->create($data);
    }

    public function updateBranch(array $data, int $id): mixed
    {
        return $this->branchRepository->update($data, $id);
    }

    public function deleteBranchById(int $id): void
    {
        return $this->branchRepository->delete($id);
    }
}
