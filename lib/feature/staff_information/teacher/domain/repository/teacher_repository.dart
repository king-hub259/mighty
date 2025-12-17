import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/staff_information/teacher/domain/model/teacher_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class TeacherRepository{
  final ApiClient apiClient;
  TeacherRepository({required this.apiClient});

  Future<Response?> getTeacherList(int page ) async {
    return await apiClient.getData("${AppConstants.teacher}?per_page=20&page=$page");
  }

  Future<Response?> addNewTeacher(TeacherBody teacherBody, XFile? profileImage ) async {
    return await apiClient.postMultipartData(AppConstants.teacher,
        teacherBody.toJson(),[],MultipartBody('image', profileImage),[]
    );
  }

  Future<Response?> updateTeacher(TeacherBody teacherBody, XFile? profileImage, int id ) async {
    return await apiClient.postMultipartData("${AppConstants.teacher}/$id",
        teacherBody.toJson(),[],MultipartBody('image', profileImage),[]
    );
  }

  Future<Response?> teacherDetails(int id ) async {
    return await apiClient.getData("${AppConstants.teacher}/$id");
  }

  Future<Response?> deleteTeacher(int id ) async {
    return await apiClient.deleteData("${AppConstants.teacher}/$id");
  }


}