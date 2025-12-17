import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/account_management/accounting_group/domain/model/accounting_group_model.dart';
import 'package:mighty_school/feature/account_management/accounting_group/domain/repository/account_group_repository.dart';


class AccountingGroupController extends GetxController implements GetxService{
  final AccountGroupRepository accountGroupRepository;
  AccountingGroupController({required this.accountGroupRepository});




  bool isLoading = false;
  AccountingGroupModel? accountingGroupModel;
  Future<void> getAccountingGroupList(int offset, {String search = ""}) async {
    isLoading = true;
    Response? response = await accountGroupRepository.getAccountingGroupList(offset, search: search);
    if (response?.statusCode == 200) {
      if(offset == 1){
        accountingGroupModel = AccountingGroupModel.fromJson(response?.body);
      }else{
        accountingGroupModel?.data?.data?.addAll(AccountingGroupModel.fromJson(response?.body).data!.data!);
        accountingGroupModel?.data?.currentPage = AccountingGroupModel.fromJson(response?.body).data?.currentPage;
        accountingGroupModel?.data?.total = AccountingGroupModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  AccountingGroupItem? selectedAccountingGroupItem;
  void selectAccountGroupItem(AccountingGroupItem item) {
    selectedAccountingGroupItem = item;
    update();
  }

  Future<void> createNewAccountingGroup( String name, int categoryId,) async {
    isLoading = true;
    update();
    Response? response = await accountGroupRepository.createNewAccountingGroup(name, categoryId);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAccountingGroupList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateAccountingGroup(String name,  int categoryId, int id) async {
    isLoading = true;
    update();
    Response? response = await accountGroupRepository.updateAccountingGroup(name, categoryId, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAccountingGroupList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteAccountingGroup(int id) async {
    isLoading = true;
    Response? response = await accountGroupRepository.deleteAccountingGroup(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAccountingGroupList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

}