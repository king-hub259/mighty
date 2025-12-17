
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/fees_management/paid_info/domain/model/paid_report_model.dart';
import 'package:mighty_school/feature/fees_management/paid_info/domain/model/un_paid_report_model.dart';
import 'package:mighty_school/feature/fees_management/paid_info/domain/repository/paid_info_repository.dart';

class PaidInfoController extends GetxController implements GetxService{
  final PaidInfoRepository paidInfoRepository;
  PaidInfoController({required this.paidInfoRepository});

  PaidReportModel? paidReportModel;
  Future<void> getPaidFeeInfoList(String from, String to) async {
    Response? response = await paidInfoRepository.getPaidInfo(from, to);
    if(response?.statusCode == 200){
      paidReportModel = PaidReportModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  UnPaidReportModel? unPaidReportModel;
  Future<void> getUnPaidReport() async {
    Response? response = await paidInfoRepository.getUnPaidInfo();
    if (response?.statusCode == 200) {
      unPaidReportModel  = UnPaidReportModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

}