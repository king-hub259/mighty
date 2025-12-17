import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/sms/phone_book/domain/models/phone_book_body.dart';
import 'package:mighty_school/feature/sms/phone_book/domain/models/phone_book_model.dart';
import 'package:mighty_school/feature/sms/phone_book/domain/repository/phone_book_repository.dart';

class PhoneBookController extends GetxController implements GetxService{
  final PhoneBookRepository phoneBookRepository;
  PhoneBookController({required this.phoneBookRepository});




  bool isLoading = false;
  PhoneBookModel? phoneBookModel;
  Future<void> getPhoneBookList() async {
    Response? response = await phoneBookRepository.getPhoneBookList();
    if (response?.statusCode == 200) {
      phoneBookModel = PhoneBookModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createPhoneBook(PhoneBookBody phoneBook) async {
    isLoading = true;
    update();
    Response? response = await phoneBookRepository.createPhoneBook(phoneBook);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getPhoneBookList();

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updatePhoneBook(PhoneBookBody phoneBook, int id) async {
    isLoading = true;
    update();
    Response? response = await phoneBookRepository.updatePhoneBook(phoneBook, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getPhoneBookList();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deletePhoneBook(int id) async {
    isLoading = true;
    Response? response = await phoneBookRepository.deletePhoneBook(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getPhoneBookList();
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
}