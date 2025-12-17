
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/routine_management/assignment/controller/assignment_controller.dart';
import 'package:mighty_school/feature/routine_management/syllabus/domain/models/syllabus_model.dart';
import 'package:mighty_school/feature/routine_management/syllabus/domain/repository/syllabus_repository.dart';

class SyllabusController extends GetxController implements GetxService{
  final SyllabusRepository syllabusRepository;
  SyllabusController({required this.syllabusRepository});




  bool isLoading = false;
  SyllabusModel? syllabusModel;
  Future<void> getSyllabusList(int offset) async {
    Response? response = await syllabusRepository.getSyllabusList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        syllabusModel = SyllabusModel.fromJson(response?.body);
      }else{
        syllabusModel?.data?.data?.addAll(SyllabusModel.fromJson(response?.body).data!.data!);
        syllabusModel?.data?.currentPage = SyllabusModel.fromJson(response?.body).data?.currentPage;
        syllabusModel?.data?.total = SyllabusModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  Future<void> createNewSyllabus(String title, String description, String classId,) async {
    isLoading = true;
    update();
    Response? response = await syllabusRepository.createNewSyllabus(title, description, classId, Get.find<AssignmentController>().documents);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getSyllabusList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateSyllabus(String title, String description, String classId, int id) async {
    isLoading = true;
    update();
    Response? response = await syllabusRepository.updateSyllabus(title, description, classId,  Get.find<AssignmentController>().documents, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getSyllabusList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteDepartment(int id) async {
    isLoading = true;
    Response? response = await syllabusRepository.deleteSyllabus(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getSyllabusList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  
}