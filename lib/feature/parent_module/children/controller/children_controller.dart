
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/parent_module/children/domain/model/behavior_model.dart';
import 'package:mighty_school/feature/parent_module/children/domain/model/children_model.dart';
import 'package:mighty_school/feature/parent_module/children/domain/repository/children_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';

class ChildrenController extends GetxController implements GetxService{
  final ChildrenRepository childrenRepository;
  ChildrenController({required this.childrenRepository});

  ChildrenModel? childrenModel;
  Future<void> getChildrenList() async {
    Response? response = await childrenRepository.getChildrenList();
    if(response?.statusCode == 200){
      childrenModel = ChildrenModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  Future<void> setDefaultChildren(String id) async {
    Response? response = await childrenRepository.setDefaultChildren(id);
    if(response!.statusCode == 200){
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      Get.find<ParentProfileController>().getProfileInfo();

    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  ChildrenItem? selectedChildrenItem;
  void setSelectChildren(ChildrenItem? item) async {
    selectedChildrenItem = item;
    if(item != null) {
      await setDefaultChildren(item.id.toString());
    }
    update();
  }


  BehaviorModel? behaviorsModel;
  Future<void> getChildrenBehaviors(int page) async {
    Response? response = await childrenRepository.getChildrenBehaviors(page);
    if(response!.statusCode == 200){
      if(page == 1){
        behaviorsModel = BehaviorModel.fromJson(response.body);
      }else{
        behaviorsModel?.data?.data?.addAll(BehaviorModel.fromJson(response.body).data!.data!);
        behaviorsModel?.data?.currentPage = BehaviorModel.fromJson(response.body).data?.currentPage;
        behaviorsModel?.data?.total = BehaviorModel.fromJson(response.body).data?.total;
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

}