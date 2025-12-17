import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/cms_management/feedback/domain/model/feedback_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class FeedbackRepository {
  final ApiClient apiClient;

  FeedbackRepository({required this.apiClient});
  
  Future<Response?> getFeedback(int page) async {
    return await apiClient.getData("${AppConstants.feedback}?page=$page");
  }

  Future<Response?> createFeedback(FeedbackBody body) async {
    return await apiClient.postData(AppConstants.feedback, body.toJson());
  }

  Future<Response?> editFeedback(FeedbackBody body, int id) async {
    return await apiClient.postData("${AppConstants.feedback}/$id", body.toJson());
  }

  Future<Response?> deleteFeedback(int id) async {
    return await apiClient.deleteData("${AppConstants.feedback}/$id");
  }
}
  