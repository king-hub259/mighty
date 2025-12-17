<?php

declare(strict_types=1);

namespace Modules\Academic\Repositories;

use App\Interfaces\BaseRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Modules\Academic\Models\Section;

class SectionRepository implements BaseRepositoryInterface
{
    public function all(): Collection
    {
        return Section::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->get();
    }

    public function paginate(int $perPage = 100, array $filter = []): LengthAwarePaginator
    {
        $query = Section::query();

        return $query->where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->paginate($perPage);
    }

    public function create(array $data): ?Section
    {
        return Section::create($data);
    }

    public function update(array $data, int $id): mixed
    {
        return Section::find($id)->update($data);
    }

    public function delete(int $id): int
    {
        return Section::destroy($id);
    }

    public function show(int $id): ?Section
    {
        return Section::find($id);
    }

    public function getSections(): Collection
    {
        return Section::select('id', 'section_name', 'class_id')->get();
    }

    public function getSectionsByClassId(int $id): Collection
    {
        return Section::where('class_id', $id)->select('id', 'class_id', 'section_name')->get();
    }
}
