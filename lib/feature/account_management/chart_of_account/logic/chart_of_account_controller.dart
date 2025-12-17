import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/domain/model/char_of_account_model.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/domain/repository/chart_of_account_repository.dart';


class ChartOfAccountController extends GetxController implements GetxService{
  final ChartOfAccountRepository chartOfAccountRepository;
  ChartOfAccountController({required this.chartOfAccountRepository});

  bool isLoading = false;
  ChartOfAccountModel? chartOfAccountModel;
  Future<void> getChartOfAccount(int page) async {
    Response? response = await chartOfAccountRepository.getChartOAccount(page);
    if(response?.statusCode == 200){
      if(page == 1) {
        chartOfAccountModel = ChartOfAccountModel.fromJson(response?.body);
      }else{
        chartOfAccountModel?.data?.data?.addAll(ChartOfAccountModel.fromJson(response?.body).data!.data!);
        chartOfAccountModel?.data?.currentPage = ChartOfAccountModel.fromJson(response?.body).data?.currentPage;
        chartOfAccountModel?.data?.total = ChartOfAccountModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }

    update();
  }

}