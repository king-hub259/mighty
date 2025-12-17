import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/account_management/accounting_category/domain/models/accounting_category_model.dart';
import 'package:mighty_school/feature/account_management/accounting_category/domain/repository/accounting_category_repository.dart';

class AccountingCategoryController extends GetxController implements GetxService{
  final AccountingCategoryRepository accountingCategoryRepository;
  AccountingCategoryController({required this.accountingCategoryRepository});




  bool isLoading = false;
  AccountingCategoryModel? accountingCategoryModel;
  Future<void> getAccountingCategoryList(int offset) async {
    Response? response = await accountingCategoryRepository.getAccountingCategoryList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        accountingCategoryModel = AccountingCategoryModel.fromJson(response?.body);
      }else{
        accountingCategoryModel?.data?.data?.addAll(AccountingCategoryModel.fromJson(response?.body).data!.data!);
        accountingCategoryModel?.data?.currentPage = AccountingCategoryModel.fromJson(response?.body).data?.currentPage;
        accountingCategoryModel?.data?.total = AccountingCategoryModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  List<String> accountingTypes = ['Asset', 'Liability', 'Income', 'Revenue', 'Expense'];
  String selectedType = "Asset";
  void setSelectedType(String type){
    selectedType = type;
    update();
  }


  Future<void> createNewAccountingCategory( String name, String description,) async {
    isLoading = true;
    update();
    Response? response = await accountingCategoryRepository.createNewAccountingCategory(name, description );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAccountingCategoryList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateAccountingCategory( String name, String description, int id) async {
    isLoading = true;
    update();
    Response? response = await accountingCategoryRepository.updateAccountingCategory(name, description, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAccountingCategoryList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteAccountingCategory(int id) async {
    isLoading = true;
    Response? response = await accountingCategoryRepository.deleteAccountingCategory(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAccountingCategoryList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  AccountingCategoryItem? selectedAccountingCategory;
  void selectAccountingCategory(AccountingCategoryItem item){
    selectedAccountingCategory = item;
    update();
  }
  
}