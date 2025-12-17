import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/models/student_attendance_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class StudentAttendanceRepository{
  final ApiClient apiClient;
  StudentAttendanceRepository({required this.apiClient});



  Future<Response?> getStudentListForAttendance(int classId, int sectionId, int periodId, String date) async {
    return await apiClient.getData("${AppConstants.studentAttendance}?class_id=$classId&section_id=$sectionId&period_id=$periodId&date=$date");
  }

  Future<Response?> getStudentAttendanceList(int page) async {
    return await apiClient.getData("${AppConstants.attendance}?page=$page&perPage=10");
  }

  Future<Response?> createNewStudentAttendance(StudentAttendanceBody attendanceBody) async {
    return await apiClient.postData(AppConstants.studentAttendance, attendanceBody.toJson());
  }

  Future<Response?> updateAttendance(StudentAttendanceBody attendanceBody, int id) async {
    return await apiClient.putData("${AppConstants.attendance}/$id", attendanceBody.toJson());
  }

  Future<Response?> deleteAttendance (int id) async {
    return await apiClient.deleteData("${AppConstants.attendance}/$id");
  }
}