import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/domain/model/account_fund_model.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/domain/repository/account_funds_repository.dart';


class AccountingFundController extends GetxController implements GetxService{
  final AccountFundRepository accountFundRepository;
  AccountingFundController({required this.accountFundRepository});




  bool isLoading = false;
  AccountingFundModel? accountingFundModel;
  Future<void> getAccountingFundList(int offset) async {
    isLoading = true;
    Response? response = await accountFundRepository.getAccountingFundList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        accountingFundModel = AccountingFundModel.fromJson(response?.body);
      }else{
        accountingFundModel?.data?.data?.addAll(AccountingFundModel.fromJson(response?.body).data!.data!);
        accountingFundModel?.data?.currentPage = AccountingFundModel.fromJson(response?.body).data?.currentPage;
        accountingFundModel?.data?.total = AccountingFundModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  AccountingFundItem? selectedAccountingFundItem;
  void selectAccountingFundItem(AccountingFundItem item) {
    selectedAccountingFundItem = item;
    update();
  }

  Future<void> createNewAccountingFund( String name,) async {
    isLoading = true;
    update();
    Response? response = await accountFundRepository.createNewAccountingFund(name);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAccountingFundList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateAccountingFund(String name, int id) async {
    isLoading = true;
    update();
    Response? response = await accountFundRepository.updateAccountingFund(name, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAccountingFundList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteAccountingFund(int id) async {
    isLoading = true;
    Response? response = await accountFundRepository.deleteAccountingFund(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAccountingFundList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

}