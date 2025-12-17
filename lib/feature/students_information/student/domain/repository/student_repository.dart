import 'dart:developer';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/students_information/student/domain/model/student_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class StudentRepository{
  final ApiClient apiClient;
  StudentRepository({required this.apiClient});

  Future<Response?> getStudentList(int classId, int period, int? sectionId, String date ) async {
    return await apiClient.getData("${AppConstants.student}?class_id=$classId&period_id=$period&section_id=$sectionId&date=$date");
  }

  Future<Response?> addNewStudent(StudentBody studentBody, XFile? profileImage ) async {
    return await apiClient.postMultipartData(AppConstants.student,
      studentBody.toJson(),[],MultipartBody('image', profileImage),[]
    );
  }

  Future<Response?> studentDetails(int id ) async {
    return await apiClient.getData("${AppConstants.student}/$id");
  }

  Future<Response?> getAllStudent(int page) async {
    return await apiClient.getData("${AppConstants.allStudent}?page=$page&per_page=30");
  }

  Future<Response?> bulkStudentImport(int sessionId, int classId, int groupId, int sectionId, MultipartDocument csvFile ) async {
    log("message=> sessionId: $sessionId, classId: $classId, groupId: $groupId, sectionId: $sectionId , csvFile: ${csvFile.key} ${csvFile.file}");
    return await apiClient.postMultipartData(AppConstants.bulkStudentImport,
      {
        'academic_year': sessionId.toString(),
        'class_id': classId.toString(),
        'group': groupId.toString(),
        'section_id': sectionId.toString(),
      },[], null,  [], videoFile: csvFile
    );
  }


}