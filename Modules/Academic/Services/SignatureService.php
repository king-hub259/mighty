<?php

declare(strict_types=1);

namespace Modules\Academic\Services;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Intervention\Image\Facades\Image;
use Modules\Academic\Models\Signature;
use Modules\Academic\Repositories\SignatureRepository;

class SignatureService
{
    public function __construct(
        private readonly SignatureRepository $signatureRepository
    ) {}

    public function getSignatures(array $filter = [], int $perPage = 100): LengthAwarePaginator
    {
        return $this->signatureRepository->paginate($perPage, $filter);
    }

    public function findSignatureById(int $id): ?Signature
    {
        return $this->signatureRepository->show((int) $id);
    }

    public function createSignature(array $data): ?Signature
    {
        $data['institute_id'] = get_institute_id();
        $data['branch_id'] = get_branch_id();

        $data = $this->prepareForDB($data);

        return $this->signatureRepository->create($data);
    }

    public function updateSignature(array $data, int $id): mixed
    {
        $data = $this->prepareForDB($data);

        return $this->signatureRepository->update($data, $id);
    }

    public function deleteSignatureById(int $id): int
    {
        return $this->signatureRepository->delete($id);
    }

    public function prepareForDB(array $data): array
    {
        if (isset($data['image'])) {
            if ($data['image']->isValid()) {
                $image = $data['image'];
                $ImageName = time().'.'.$image->getClientOriginalExtension();
                Image::make($image)->resize(280, 70)->save(base_path('public/uploads/images/signatures/').$ImageName);
                $data['image'] = 'signatures/'.$ImageName;
            }
        }

        return $data;
    }
}
