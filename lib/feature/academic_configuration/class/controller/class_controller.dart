
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:mighty_school/feature/academic_configuration/class/domain/repository/class_repository.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';

class ClassController extends GetxController implements GetxService{
  final ClassRepository classRepository;
  ClassController({required this.classRepository});

  ClassModel? classModel;
  Future<void> getClassList({int perPage = 10, int page =1}) async {
    Response? response = await classRepository.getClassList(perPage: perPage, page: page);
    if(response?.statusCode == 200){
      if(page == 1){
        classModel = ClassModel.fromJson(response?.body);
      }else{
        classModel?.data?.data?.addAll(ClassModel.fromJson(response?.body).data!.data!);
        classModel?.data?.currentPage = ClassModel.fromJson(response?.body).data?.currentPage;
        classModel?.data?.total = ClassModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }



  ClassItem? selectedClassItem;
  ClassItem? selectedClassItemToMigration;
  void setSelectClass(ClassItem? classItem, {bool fromMigration = false}) async {
    if(fromMigration){
      selectedClassItemToMigration = classItem;
      Get.find<SectionController>().getSectionList(1, fromMigration: true);
      Get.find<SubjectController>().getClassWiseSubjectList(classItem!.id!);
    }else{
      selectedClassItem = classItem;
      Get.find<SectionController>().getSectionList(1);
      Get.find<SubjectController>().getClassWiseSubjectList(classItem!.id!);
    }

    update();
  }

  bool isLoading = false;

  Future<void> addNewClassList(String name) async {
    isLoading = true;
    update();
    Response? response = await classRepository.addNewClassList(name);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("class_added_successfully".tr, isError: false);
      getClassList();
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> updateClassList(String name, int id) async {
    isLoading = true;
    update();
    Response? response = await classRepository.classEdit(name, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("class_updated_successfully".tr.tr, isError: false);
      getClassList();

    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> classDetails(int id) async {
    Response? response = await classRepository.classDetails(id);
    if(response!.statusCode == 200){

    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> deleteClass(int id) async {
    Response? response = await classRepository.classDelete(id);
    if(response!.statusCode == 200){
      showCustomSnackBar("class_deleted_successfully".tr, isError: false);
      getClassList();
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
}