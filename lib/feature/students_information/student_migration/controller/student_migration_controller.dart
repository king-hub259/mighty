
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/students_information/student/domain/model/student_model.dart';
import 'package:mighty_school/feature/students_information/student_migration/domain/models/migration_body.dart';
import 'package:mighty_school/feature/students_information/student_migration/domain/repository/student_migration_repository.dart';

class StudentMigrationController extends GetxController implements GetxService{
  final StudentMigrationRepository studentMigrationRepository;
  StudentMigrationController({required this.studentMigrationRepository});


  bool isLoading = false;
  StudentModel? studentModelForMigration;
  Future<void> getStudentListForMigration(int classId, sectionId) async {
    Response? response = await studentMigrationRepository.getStudentForMigration(classId, sectionId);
    if(response?.statusCode == 200){
      studentModelForMigration = StudentModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  StudentModel? migrationModel;
  Future<void> getMigrationList(int academicYeaId, int sectionId) async {
    Response? response = await studentMigrationRepository.getMigrationList(academicYeaId, sectionId);
    if(response?.statusCode == 200){
      migrationModel = StudentModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }





  void updateSelection(int index){
    studentModelForMigration?.data?[index].isSelected = !studentModelForMigration!.data![index].isSelected!;
    update();
  }

  bool allSelected = false;
  void selectAll(){
    studentModelForMigration?.data?.forEach((element) {
      element.isSelected = allSelected;
      element.isSelected = !element.isSelected!;
    });
    allSelected = !allSelected;
    update();
  }

  List<String> migrationTypes = ['withmarit', 'withoutmerit'];
  String selectedMigrationType = 'withmarit';
  void changeMigrationType(String type){
    selectedMigrationType = type;
    update();
  }



  Future<void> studentMigration(MigrationBody body) async {
    isLoading = true;
    update();
    Response? response = await studentMigrationRepository.studentMigration(body);
    if(response?.statusCode == 200){
      log("message==> ${body.toJson()}");
      Get.back();
      isLoading = false;
      showCustomSnackBar("migration_success".tr, isError: false);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


}