import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hrm/leave_request/domain/models/leave_request_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class LeaveRequestRepository{
  final ApiClient apiClient;
  LeaveRequestRepository({required this.apiClient});


  Future<Response?> getLeaveRequestList(int page) async {
    return await apiClient.getData("${AppConstants.leaveRequest}?page=$page&perPage=10");
  }


  Future<Response?> createNewLeaveRequest( LeaveRequestBody leaveRequestBody, XFile? evidence,) async {
    Map<String, String> fields = <String, String> {
      "user_id": leaveRequestBody.userId?.toString()??"",
      "leave_type_id": leaveRequestBody.leaveTypeId?.toString()??'',
      "start_date": leaveRequestBody.startDate??'',
      "end_date": leaveRequestBody.endDate??'',
      "approval_status": leaveRequestBody.approvalStatus??'',
      "notes": leaveRequestBody.notes??''
    };

    return await apiClient.postMultipartData(
      AppConstants.leaveRequest,
      fields, [], MultipartBody('evidence',evidence), [],
    );
  }

  Future<Response?> updateLeaveRequest( LeaveRequestBody leaveRequestBody, XFile? evidence, int id) async {
    Map<String, String> fields = <String, String> {
      "user_id": leaveRequestBody.userId?.toString()??"",
      "leave_type_id": leaveRequestBody.leaveTypeId?.toString()??'',
      "start_date": leaveRequestBody.startDate??'',
      "end_date": leaveRequestBody.endDate??'',
      "approval_status": leaveRequestBody.approvalStatus??'',
      "notes": leaveRequestBody.notes??''
    };

    return await apiClient.postMultipartData(
      "${AppConstants.leaveRequest}/$id",
      fields, [], MultipartBody('evidence',evidence), [],
    );
  }


  Future<Response?> deleteLeaveRequest (int id) async {
    return await apiClient.deleteData("${AppConstants.leaveRequest}/$id");
  }
}