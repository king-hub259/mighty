import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/package_plan/domain/models/package_body.dart';
import 'package:mighty_school/feature/package_plan/domain/models/package_model.dart';
import 'package:mighty_school/feature/package_plan/domain/repository/package_repository.dart';

class PackageController extends GetxController implements GetxService{
  final PackageRepository packageRepository;
  PackageController({required this.packageRepository});




  bool isLoading = false;
  PackageModel? packageModel;
  Future<void> getPackageList(int offset) async {
    Response? response = await packageRepository.getPackageList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        packageModel = PackageModel.fromJson(response?.body);
      }else{
        packageModel?.data?.data?.addAll(PackageModel.fromJson(response?.body).data!.data!);
        packageModel?.data?.currentPage = PackageModel.fromJson(response?.body).data?.currentPage;
        packageModel?.data?.total = PackageModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createNewPackage(PackageBody body,) async {
    isLoading = true;
    update();
    Response? response = await packageRepository.createNewPackage(body);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getPackageList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updatePackage(PackageBody body, int id) async {
    isLoading = true;
    update();
    Response? response = await packageRepository.updatePackage(body, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getPackageList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deletePackage(int id) async {
    isLoading = true;
    Response? response = await packageRepository.deletePackage(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getPackageList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  PackageItem? selectedPackageItem;
  void selectPackage(PackageItem item){
    selectedPackageItem = item;
    update();
  }
  
}