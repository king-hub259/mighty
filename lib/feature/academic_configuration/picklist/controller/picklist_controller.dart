
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/domain/models/pick_list_model.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/domain/repository/picklist_repository.dart';

class PickListController extends GetxController implements GetxService{
  final PickListRepository pickListRepository;
  PickListController({required this.pickListRepository});




  bool isLoading = false;
  PickListModel? pickListModel;
  Future<void> getPickList(int offset) async {
    Response? response = await pickListRepository.getPickList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        pickListModel = PickListModel.fromJson(response?.body);
      }else{
        pickListModel?.data?.data?.addAll(PickListModel.fromJson(response?.body).data!.data!);
        pickListModel?.data?.currentPage = PickListModel.fromJson(response?.body).data?.currentPage;
        pickListModel?.data?.total = PickListModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  List<String> picklistTypes = ["Religion", "Designation", "Department"];
  String selectedPicklistType = "Religion";
  void changePicklistType(String type){
    selectedPicklistType = type;
    getPickList(1);
  }


  PickListItem? selectedPicklistItem;
  void selectPicklistItem(PickListItem item){
    selectedPicklistItem = item;
    update();
  }

  Future<void> createNewPickList( String name, String description,) async {
    isLoading = true;
    update();
    Response? response = await pickListRepository.createNewPickList(name, description );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getPickList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updatePickList( String name, String description, int id) async {
    isLoading = true;
    update();
    Response? response = await pickListRepository.updatePickList(name, description, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getPickList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deletePickList(int id) async {
    isLoading = true;
    Response? response = await pickListRepository.deletePickLis(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getPickList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
}