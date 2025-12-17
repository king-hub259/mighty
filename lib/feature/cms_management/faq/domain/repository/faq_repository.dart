import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class FaqRepository {
  final ApiClient apiClient;

  FaqRepository({required this.apiClient});
  
  Future<Response?> getFaq(int page) async {
    return await apiClient.getData("${AppConstants.faqs}?page=$page");
  }

  Future<Response?> createFaq(String question, String answer) async {
    return await apiClient.postData(AppConstants.faqs, {
      "question": question,
      "answer": answer,
    });
  }

  Future<Response?> editFaq(String question, String answer, int id) async {
    return await apiClient.postData("${AppConstants.faqs}/$id", {
      "question": question,
      "answer": answer,
      "_method": "put",
    });
  }


  Future<Response?> deleteFaq(int id) async {
    return await apiClient.deleteData("${AppConstants.faqs}/$id");
  }
}
  