
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/domain/model/parent_paid_report_model.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/domain/model/parent_un_paid_report_model.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/domain/repository/parent_paid_info_repository.dart';

class ParentPaidInfoController extends GetxController implements GetxService{
  final ParentPaidInfoRepository paidInfoRepository;
  ParentPaidInfoController({required this.paidInfoRepository});

  ParentPaidReportModel? paidReportModel;
  Future<void> getPaidFeeInfoList() async {
    Response? response = await paidInfoRepository.getPaidInfo();
    if(response?.statusCode == 200){
      paidReportModel = ParentPaidReportModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  ParentUnPaidReportModel? unPaidReportModel;
  Future<void> getUnPaidReport() async {
    Response? response = await paidInfoRepository.getUnPaidInfo();
    if (response?.statusCode == 200) {
      unPaidReportModel  = ParentUnPaidReportModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  int selectedFeesTypeIndex = 0;
  void setSelectedFeesTypeIndex(int index) {
    selectedFeesTypeIndex = index;
    update();
  }

}