import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/cms_management/feedback/domain/model/feedback_body.dart';
import 'package:mighty_school/feature/cms_management/feedback/domain/model/feedback_model.dart';
import 'package:mighty_school/feature/cms_management/feedback/domain/repository/feedback_repository.dart';

class FeedbackController extends GetxController implements GetxService {
  final FeedbackRepository feedbackRepository;
  FeedbackController({required this.feedbackRepository});

  FeedbackModel? feedbackModel;
  Future<void> getFeedback(int page) async {
    Response? response = await feedbackRepository.getFeedback(page);
    if (response?.statusCode == 200) {
      if(page == 1) {
        feedbackModel = FeedbackModel.fromJson(response?.body);
      }else{
        feedbackModel?.data?.data?.addAll(FeedbackModel.fromJson(response?.body).data?.data ?? []);
        feedbackModel?.data?.total = FeedbackModel.fromJson(response?.body).data?.total;
        feedbackModel?.data?.currentPage = FeedbackModel.fromJson(response?.body).data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }



  bool loading = false;
  Future<void> createFeedback(FeedbackBody body) async {
    loading = true;
    update();
    Response? response = await feedbackRepository.createFeedback(body);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getFeedback(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editFeedback(FeedbackBody body, int id) async {
    loading = true;
    update();
    Response? response = await feedbackRepository.editFeedback(body, id);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getFeedback(1);
      
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteFeedback(int id) async {
    Response? response = await feedbackRepository.deleteFeedback(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getFeedback(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  