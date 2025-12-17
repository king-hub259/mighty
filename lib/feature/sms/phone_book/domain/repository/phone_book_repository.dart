import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/sms/phone_book/domain/models/phone_book_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class PhoneBookRepository{
  final ApiClient apiClient;
  PhoneBookRepository({required this.apiClient});


  Future<Response?> getPhoneBookList() async {
    return await apiClient.getData(AppConstants.phoneBook);
  }

  Future<Response?> createPhoneBook(PhoneBookBody phoneBook) async {
    return await apiClient.postData(AppConstants.phoneBook, phoneBook.toJson());
  }

  Future<Response?> updatePhoneBook(PhoneBookBody phoneBook, int id) async {
    return await apiClient.putData("${AppConstants.phoneBook}/$id", phoneBook.toJson());
  }
  

  Future<Response?> deletePhoneBook (int id) async {
    return await apiClient.deleteData("${AppConstants.phoneBook}/$id");
  }
}