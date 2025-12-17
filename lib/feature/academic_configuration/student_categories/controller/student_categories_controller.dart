
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/domain/model/student_categories_model.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/domain/repository/studnt_categories_repository.dart';

class StudentCategoriesController extends GetxController implements GetxService{
  final StudentCategoriesRepository studentCategoriesRepository;
  StudentCategoriesController({required this.studentCategoriesRepository});

  StudentCategoriesModel? studentCategoriesModel;
  Future<void> getStudentCategoriesList({int perPage = 10, int page =1}) async {
    Response? response = await studentCategoriesRepository.getStudentCategoriesList(perPage: perPage, page: page);
    if(response?.statusCode == 200){
      if(page == 1){
        studentCategoriesModel = StudentCategoriesModel.fromJson(response?.body);
      }else{
        studentCategoriesModel?.data?.data?.addAll(StudentCategoriesModel.fromJson(response?.body).data!.data!);
        studentCategoriesModel?.data?.currentPage = StudentCategoriesModel.fromJson(response?.body).data?.currentPage;
        studentCategoriesModel?.data?.total = StudentCategoriesModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }



  StudentCategoryItem? selectedStudentCategories;
  void setSelectStudentCategories(StudentCategoryItem? item) async {
    selectedStudentCategories = item;
    update();
  }

  bool isLoading = false;

  Future<void> addNewStudentCategories(String name) async {
    isLoading = true;
    update();
    Response? response = await studentCategoriesRepository.addNewStudentCategories(name);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getStudentCategoriesList();
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> updateStudentCategory(String name, int id) async {
    isLoading = true;
    update();
    Response? response = await studentCategoriesRepository.studentCategoriesEdit(name, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr.tr, isError: false);
      getStudentCategoriesList();

    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> studentCategoryDetails(int id) async {
    Response? response = await studentCategoriesRepository.studentCategoriesDetails(id);
    if(response!.statusCode == 200){

    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> deleteStudentCategory(int id) async {
    Response? response = await studentCategoriesRepository.studentCategoriesDelete(id);
    if(response!.statusCode == 200){
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getStudentCategoriesList();
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
}