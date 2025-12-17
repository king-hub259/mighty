import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/students_information/student_migration/domain/models/migration_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class StudentMigrationRepository{
  final ApiClient apiClient;
  StudentMigrationRepository({required this.apiClient});


  Future<Response?> getStudentForMigration(int classId, int sectionId) async {
    return await apiClient.getData("${AppConstants.getStudentForMigration}?class_id=$classId&section_id=$sectionId");
  }

  Future<Response?> getMigrationList(int academicYeaId, int sectionId) async {
    return await apiClient.getData("${AppConstants.geMigrationList}?section_id=$sectionId&academic_year_id=$academicYeaId");
  }

  Future<Response?> studentMigration(MigrationBody body) async {
    return await apiClient.postData(AppConstants.studentMigration, body.toJson());
  }

}