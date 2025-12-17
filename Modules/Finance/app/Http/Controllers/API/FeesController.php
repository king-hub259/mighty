<?php

namespace Modules\Finance\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Models\AbsentFine;
use Modules\Academic\Models\Section;
use Modules\Academic\Services\SectionService;
use Modules\Finance\Http\Requests\FeesCreateRequest;
use Modules\Finance\Models\Fee;
use Modules\Finance\Services\AbsentFineService;
use Modules\Finance\Services\FeeService;

class FeesController extends Controller
{
    public function __construct(
        private readonly SectionService $sectionService,
        private readonly FeeService $feeService,
        private readonly AbsentFineService $absentFineService
    ) {}

    public function index(Request $request): JsonResponse
    {
        $perPage = (int) $request->per_page ?: 10;
        $type = $request->type;

        try {
            // Initialize an empty variable for the result
            $data = [];

            // Fetch data based on the `type` parameter
            if ($type === 'absent_fine_amount') {
                $data = AbsentFine::orderBy('id', 'asc')->where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->paginate($perPage);
            } else {
                $data = Fee::with(
                    'class',
                    'section',
                    'group',
                    'studentCategory',
                    'feeHead',
                )->orderBy('id', 'asc')->where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->paginate($perPage);
            }

            return $this->responseSuccess(
                $data,
                _lang('Data has been fetched successfully.')
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function store(FeesCreateRequest $request): JsonResponse
    {
        $studentSectionGet = Section::where('class_id', $request->class_id)->where('student_group_id', $request->group_id)->get();
        if (! $studentSectionGet) {
            return $this->responseError([], _lang('Something went wrong. Fee can not be submitted.'));
        }

        // Initialize an array to store all fee_head results
        $fee_heads = [];
        foreach ($studentSectionGet as $studentSection) {
            $requestData = array_merge($request->validated(), ['section_id' => $studentSection->id]);

            // Create fee_head using merged request data
            $fee_head = $this->feeService->createFee($requestData);

            // Store fee_head result
            $fee_heads[] = $fee_head;
        }

        // Check if any fee_head is created
        if (empty(array_filter($fee_heads))) {
            return $this->responseError([], _lang('Something went wrong. Fee can not be submitted.'));
        }

        return $this->responseSuccess(
            [],
            _lang('Fee has been create successfully')
        );
    }

    public function show(int $id): JsonResponse
    {
        $fee = $this->feeService->findFeeById((int) $id);

        return $this->responseSuccess(
            $fee,
            _lang('Fee has been show successfully')
        );
    }

    public function update(FeesCreateRequest $request, $id): JsonResponse
    {
        $fee_head = $this->feeService->updateFee($request->validated(), $id);

        if (! $fee_head) {
            return $this->responseError([], _lang('Something went wrong. Fee can not be edit.'));
        }

        return $this->responseSuccess(
            [],
            _lang('Fee has been update successfully')
        );
    }

    public function destroy(int $id): JsonResponse
    {
        $fee = Fee::where('id', $id)->first();

        if (! empty($fee)) {
            $fee->delete();

            return $this->responseSuccess(
                [],
                _lang('Fee has been delete successfully')
            );
        } else {
            return $this->responseError([], _lang('Something went wrong. Fee can not be delete.'));
        }
    }
}
