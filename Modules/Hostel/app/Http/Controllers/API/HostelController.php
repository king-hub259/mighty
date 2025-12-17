<?php

namespace Modules\Hostel\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Hostel\Models\Hostel;

class HostelController extends Controller
{
    public function index(): JsonResponse
    {
        $hostels = Hostel::orderBy('id', 'DESC')->get();

        return $this->responseSuccess($hostels, 'Hostel fetched successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'hostel_name' => 'required',
            'type' => 'required',
            'address' => 'required',
            'note' => 'nullable',
        ]);

        $hostel = new Hostel;
        $hostel->institute_id = get_institute_id();
        $hostel->branch_id = get_branch_id();
        $hostel->hostel_name = $request->hostel_name;
        $hostel->type = $request->type;
        $hostel->address = $request->address;
        $hostel->note = $request->note;
        $hostel->save();

        return $this->responseSuccess($hostel, 'Hostel create successfully.');
    }

    public function show($id): JsonResponse
    {
        $hostel = Hostel::find($id);
        if (! $hostel) {
            return $this->responseError([], _lang('Something went wrong. Hostel can not be found.'));
        }

        return $this->responseSuccess($hostel, 'Hostel create successfully.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'hostel_name' => 'required',
            'type' => 'required',
            'address' => 'required',
            'note' => 'nullable',
        ]);

        $hostel = Hostel::find($id);
        $hostel->hostel_name = $request->hostel_name;
        $hostel->type = $request->type;
        $hostel->address = $request->address;
        $hostel->note = $request->note;
        $hostel->save();

        return $this->responseSuccess($hostel, 'Hostel update successfully.');
    }

    public function destroy($id): JsonResponse
    {
        $hostel = Hostel::find($id);
        if (! $hostel) {
            return $this->responseError([], _lang('Something went wrong. Hostel can not be found.'));
        }
        $hostel->delete();

        return $this->responseSuccess([], 'Hostel delete successfully.');
    }
}
