import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/domain/model/hostel_category_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/domain/model/hostel_category_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/domain/repository/hostel_categories_repository.dart';

class HostelCategoriesController extends GetxController implements GetxService {
  final HostelCategoriesRepository hostelCategoriesRepository;
  HostelCategoriesController({required this.hostelCategoriesRepository});

  bool isLoading = false;
  ApiResponse<HostelCategoryItem>? hostelCategoryModel;
  Future<void> getHostelCategoriesList({int page = 1}) async {
    Response? response = await hostelCategoriesRepository.getHostelCategoriesList(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<HostelCategoryItem>.fromJson(response!.body, (data) => HostelCategoryItem.fromJson(data));
      if(page == 1){
        hostelCategoryModel = apiResponse;
      }else {
        hostelCategoryModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        hostelCategoryModel?.data?.total = apiResponse.data?.total;
        hostelCategoryModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> addNewHostelCategory(HostelCategoryBody categoryBody) async {
    isLoading = true;
    update();
    Response? response = await hostelCategoriesRepository.addNewHostelCategory(categoryBody);
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      isLoading = false;
      Get.back();
      showCustomSnackBar('hostel_category_added_successfully'.tr, isError: false);
      getHostelCategoriesList();
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> updateHostelCategory(int id, HostelCategoryBody categoryBody) async {
    isLoading = true;
    update();

    Response? response = await hostelCategoriesRepository.updateHostelCategory(id, categoryBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar('hostel_category_updated_successfully'.tr, isError: false);
      getHostelCategoriesList();
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> deleteHostelCategory(int id) async {
    Response? response = await hostelCategoriesRepository.deleteHostelCategory(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar('hostel_category_deleted_successfully'.tr, isError: false);
      getHostelCategoriesList();
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }



  HostelCategoryItem? selectedCategoryItem;
  void setSelectedHostelCategory(HostelCategoryItem categoryItem, {bool notify = true}) {
    selectedCategoryItem = categoryItem;
    if(notify) {
      update();
    }
  }
}
  