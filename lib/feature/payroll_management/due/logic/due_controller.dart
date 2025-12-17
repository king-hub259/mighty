import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/payroll_management/due/domain/model/due_model.dart';
import 'package:mighty_school/feature/payroll_management/due/domain/model/due_payment_body.dart';
import 'package:mighty_school/feature/payroll_management/due/domain/repository/due_repository.dart';

class DueController extends GetxController implements GetxService {
  final DueRepository dueRepository;
  DueController({required this.dueRepository});

  DueModel? dueModel;
  Future<void> getDue(String userId) async {
    Response? response = await dueRepository.getDue(userId);
    if (response?.statusCode == 200) {
      dueModel = DueModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool loading = false;
  Future<void> duePayment(DuePaymentBody body) async {
    loading  = true;
    update();
    Response? response = await dueRepository.duePayment(body);
    if (response?.statusCode == 200) {
      Get.back();
      showCustomSnackBar("payment_successful".tr, isError: false);
      getDue(body.userId!);
    } else {
      ApiChecker.checkApi(response!);
    }
    loading = false;
    update();
  }

  Future<void> editDue() async {
    Response? response = await dueRepository.editDue();
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteDue() async {
    Response? response = await dueRepository.deleteDue();
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  