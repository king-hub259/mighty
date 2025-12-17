import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/domain/model/hostel_bill_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/domain/model/hostel_bill_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/domain/repository/hostel_bill_repository.dart';

class HostelBillController extends GetxController implements GetxService {
  final HostelBillRepository hostelBillRepository;
  HostelBillController({required this.hostelBillRepository});

  ApiResponse<HostelBillItem>? hostelBillModel;

  Future<void> getHostelBill(int page) async {
    Response? response = await hostelBillRepository.getHostelBillsList(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<HostelBillItem>.fromJson(
          response!.body, (json) => HostelBillItem.fromJson(json));
      if(page == 1){
        hostelBillModel = apiResponse;
      }else{
        hostelBillModel?.data?.data!.addAll(apiResponse.data?.data??[]);
        hostelBillModel?.data?.total = apiResponse.data?.total;
        hostelBillModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createHostelBill(HostelBillBody billBody) async {
    Response? response = await hostelBillRepository.addNewHostelBill(billBody);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editHostelBill(HostelBillBody billBody, int id) async {
    Response? response = await hostelBillRepository.updateHostelBill(id, billBody);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteHostelBill(int id) async {
    Response? response = await hostelBillRepository.deleteHostelBill(id);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  