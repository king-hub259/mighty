import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/sms/phone_book_category/domain/models/phone_book_category_model.dart';
import 'package:mighty_school/feature/sms/phone_book_category/domain/repository/phone_book_category_repository.dart';

class PhoneBookCategoryController extends GetxController implements GetxService{
  final PhoneBookCategoryRepository phoneBookCategoryRepository;
  PhoneBookCategoryController({required this.phoneBookCategoryRepository});




  bool isLoading = false;
  PhoneBookCategoryModel? phoneBookCategoryModel;
  Future<void> getPhoneBookCategoryList() async {
    Response? response = await phoneBookCategoryRepository.getPhoneBookCategoryList();
    if (response?.statusCode == 200) {
      phoneBookCategoryModel = PhoneBookCategoryModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createPhoneBookCategory( String name, String description,) async {
    isLoading = true;
    update();
    Response? response = await phoneBookCategoryRepository.createPhoneBookCategory(name, description );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getPhoneBookCategoryList();

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updatePhoneBookCategory( String name, String description, int id) async {
    isLoading = true;
    update();
    Response? response = await phoneBookCategoryRepository.updatePhoneBookCategory(name, description, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getPhoneBookCategoryList();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deletePhoneBookCategory(int id) async {
    isLoading = true;
    Response? response = await phoneBookCategoryRepository.deletePhoneBookCategory(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getPhoneBookCategoryList();
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  PhoneBookCategoryItem? selectedPhoneBookCategoryItem;
  void selectPhoneBookCategory(PhoneBookCategoryItem item) {
    selectedPhoneBookCategoryItem = item;
    update();
  }
}