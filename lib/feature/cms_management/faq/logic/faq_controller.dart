import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/cms_management/faq/domain/model/faq_model.dart';
import 'package:mighty_school/feature/cms_management/faq/domain/repository/faq_repository.dart';

class FaqController extends GetxController implements GetxService {
  final FaqRepository faqRepository;
  FaqController({required this.faqRepository});

  FaqModel? faqModel;
  Future<void> getFaq(int page) async {
    Response? response = await faqRepository.getFaq(page);
    if (response?.statusCode == 200) {
      if(page == 1) {
        faqModel = FaqModel.fromJson(response?.body);
      } else {
        faqModel?.data?.data?.addAll(FaqModel.fromJson(response?.body).data?.data ?? []);
        faqModel?.data?.total = FaqModel.fromJson(response?.body).data?.total;
        faqModel?.data?.currentPage = FaqModel.fromJson(response?.body).data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool loading = false;

  Future<void> createFaq(String question, String answer) async {
    loading = true;
    update();

    Response? response = await faqRepository.createFaq(question, answer);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getFaq(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editFaq(String question, String answer, int id) async {
    loading = true;
    update();
    Response? response = await faqRepository.editFaq(question, answer, id);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getFaq(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteFaq(int id) async {
    Response? response = await faqRepository.deleteFaq(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getFaq(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  