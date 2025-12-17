<?php

declare(strict_types=1);

namespace Modules\Teacher\Services\ClassLesson;

use App\Interfaces\BaseInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Modules\Teacher\Models\ClassLesson;

final class ClassLessonService implements BaseInterface
{
    public function __construct(
        protected ClassLesson $model
    ) {}

    public function index($request, int $per_page = 10): LengthAwarePaginator
    {
        $orderColumn = request('sort_column', 'id');
        $orderDirection = request('sort_direction', 'desc');

        if (! in_array($orderColumn, ['id', 'name', 'created_at'])) {
            $orderColumn = 'id';
        }
        if (! in_array($orderDirection, ['asc', 'desc'])) {
            $orderDirection = 'desc';
        }

        return $this->model::query()
            ->when($request->search, function ($query) use ($request) {
                $query->where('name', 'like', $request->search.'%');
            })
            ->orderBy($orderColumn, $orderDirection)
            ->paginate($per_page);
    }

    public function getAll($request): Collection
    {
        $orderColumn = request('sort_column', 'id');
        $orderDirection = request('sort_direction', 'desc');

        if (! in_array($orderColumn, ['id', 'name', 'created_at'])) {
            $orderColumn = 'id';
        }
        if (! in_array($orderDirection, ['asc', 'desc'])) {
            $orderDirection = 'desc';
        }

        return $this->model::query()
            ->when($request->search, function ($query) use ($request) {
                $query->where('name', 'like', $request->search.'%');
            })
            ->orderBy($orderColumn, $orderDirection)
            ->get();
    }

    public function getById(int $id): ?ClassLesson
    {
        $record = $this->model::find($id);

        return $record ?? null;
    }

    public function create(array $data): ClassLesson
    {
        $data['institute_id'] = get_institute_id();
        $data['branch_id'] = get_branch_id();

        return $this->model::create($data);
    }

    public function update(int $id, array $data): ?ClassLesson
    {
        $model = $this->model::where('id', $id)->first();
        $model->update($data);

        return $model;
    }

    public function delete(int $id): int
    {
        $model = $this->model::where('id', $id)->first();

        return $model->delete();
    }
}
