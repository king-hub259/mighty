import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/payroll_management/return_advance/domain/repository/return_advance_repository.dart';

class ReturnAdvanceController extends GetxController implements GetxService {
  final ReturnAdvanceRepository returnAdvanceRepository;
  ReturnAdvanceController({required this.returnAdvanceRepository});

  Future<void> getReturnAdvance() async {
    Response? response = await returnAdvanceRepository.getReturnAdvance();
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createReturnAdvance() async {
    Response? response = await returnAdvanceRepository.createReturnAdvance();
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editReturnAdvance() async {
    Response? response = await returnAdvanceRepository.editReturnAdvance();
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteReturnAdvance() async {
    Response? response = await returnAdvanceRepository.deleteReturnAdvance();
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  