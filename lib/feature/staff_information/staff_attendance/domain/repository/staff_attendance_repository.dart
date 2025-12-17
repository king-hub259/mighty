import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/domain/models/staff_attendance_bofy.dart';
import 'package:mighty_school/util/app_constants.dart';

class StaffAttendanceRepository{
  final ApiClient apiClient;
  StaffAttendanceRepository({required this.apiClient});



  Future<Response?> getStaffListForAttendance(String type) async {
    return await apiClient.getData("${AppConstants.typeWiseUserList}$type");
  }

  Future<Response?> getStaffAttendanceList(int page) async {
    return await apiClient.getData("${AppConstants.staffAttendance}?page=$page&per_page=10");
  }

  Future<Response?> createStaffAttendance(StaffAttendanceBody attendanceBody) async {
    return await apiClient.postData(AppConstants.staffAttendance, attendanceBody.toJson());
  }

  Future<Response?> updateStaffAttendance(StaffAttendanceBody attendanceBody, int id) async {
    return await apiClient.putData("${AppConstants.staffAttendance}/$id", attendanceBody.toJson());
  }

  Future<Response?> deleteStaffAttendance (int id) async {
    return await apiClient.deleteData("${AppConstants.staffAttendance}/$id");
  }
}