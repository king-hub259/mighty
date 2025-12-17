import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/domain/model/accounting_ledger_model.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/domain/repository/account_ledger_repository.dart';


class AccountLedgerController extends GetxController implements GetxService{
  final AccountLedgerRepository accountLedgerRepository;
  AccountLedgerController({required this.accountLedgerRepository});




  bool isLoading = false;
  AccountingLedgerModel? accountingLedgerModel;
  Future<void> getAccountingLedgerList(int offset) async {
    isLoading = true;
    Response? response = await accountLedgerRepository.getAccountingLedgerList(offset, "payment");
    if (response?.statusCode == 200) {
      if(offset == 1){
        accountingLedgerModel = AccountingLedgerModel.fromJson(response?.body);
      }else{
        accountingLedgerModel?.data?.data?.addAll(AccountingLedgerModel.fromJson(response?.body).data!.data!);
        accountingLedgerModel?.data?.currentPage = AccountingLedgerModel.fromJson(response?.body).data?.currentPage;
        accountingLedgerModel?.data?.total = AccountingLedgerModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  AccountingLedgerModel? accountingLedgerModelForPayment;
  Future<void> getAccountingLedgerListForPayment(int offset) async {
    Response? response = await accountLedgerRepository.getAccountingLedgerList(offset, "payment_by");
    if (response?.statusCode == 200) {
      if(offset == 1){
        accountingLedgerModelForPayment = AccountingLedgerModel.fromJson(response?.body);
      }else{
        accountingLedgerModelForPayment?.data?.data?.addAll(AccountingLedgerModel.fromJson(response?.body).data!.data!);
        accountingLedgerModelForPayment?.data?.currentPage = AccountingLedgerModel.fromJson(response?.body).data?.currentPage;
        accountingLedgerModelForPayment?.data?.total = AccountingLedgerModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


  AccountingLedgerItem? selectedAccountingLedgerItemForPayment;
  AccountingLedgerItem? selectedAccountingLedgerItemForTransaction;
  void selectAccountLedgerItem(AccountingLedgerItem item, {bool forTransaction = false}) {
    if(forTransaction){
      selectedAccountingLedgerItemForTransaction = item;
    }else{
      selectedAccountingLedgerItemForPayment = item;
      getLedgerBalance(selectedAccountingLedgerItemForPayment!.id!);
    }

    update();
  }

  double ledgerBalance = 0;
  Future<void> getLedgerBalance(int ledgerId,) async {
    Response? response = await accountLedgerRepository.getLedgerBalance(ledgerId);
    if(response!.statusCode == 200){
      ledgerBalance = response.body["balance"].toDouble();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> createNewAccountingLedger(String name, int catId, int groupId,) async {
    isLoading = true;
    update();
    Response? response = await accountLedgerRepository.createNewAccountingLedger(name, catId, groupId);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAccountingLedgerList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateAccountingLedger(String name, int catId, int groupId, int id) async {
    isLoading = true;
    update();
    Response? response = await accountLedgerRepository.updateAccountingLedger(name, catId, groupId, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAccountingLedgerList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteAccountingLedger(int id) async {
    isLoading = true;
    Response? response = await accountLedgerRepository.deleteAccountingLedger(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAccountingLedgerList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

}