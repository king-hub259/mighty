import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/department/domain/models/department_model.dart';
import 'package:mighty_school/feature/academic_configuration/department/domain/repository/department_repository.dart';

class DepartmentController extends GetxController implements GetxService{
  final DepartmentRepository departmentRepository;
  DepartmentController({required this.departmentRepository});




  bool isLoading = false;
  DepartmentModel? departmentModel;
  Future<void> getDepartmentList(int offset) async {
    Response? response = await departmentRepository.getDepartmentList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        departmentModel = DepartmentModel.fromJson(response?.body);
      }else{
        departmentModel?.data?.data?.addAll(DepartmentModel.fromJson(response?.body).data!.data!);
        departmentModel?.data?.currentPage = DepartmentModel.fromJson(response?.body).data?.currentPage;
        departmentModel?.data?.total = DepartmentModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createNewDepartment( String name, String description,) async {
    isLoading = true;
    update();
    Response? response = await departmentRepository.createNewDepartment(name, description );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("department_created_successfully".tr, isError: false);
      getDepartmentList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateDepartment( String name, String description, int id) async {
    isLoading = true;
    update();
    Response? response = await departmentRepository.updateDepartment(name, description, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("department_updated_successfully".tr, isError: false);
      getDepartmentList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteDepartment(int id) async {
    isLoading = true;
    Response? response = await departmentRepository.deleteDepartment(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("department_deleted_successfully".tr, isError: false);
      getDepartmentList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  DepartmentItem? selectedDepartmentItem;
  void selectDepartment(DepartmentItem item){
    selectedDepartmentItem = item;
    update();
  }
  
}