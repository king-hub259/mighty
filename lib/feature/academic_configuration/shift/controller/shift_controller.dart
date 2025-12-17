import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/shift/domain/models/shift_model.dart';
import 'package:mighty_school/feature/academic_configuration/shift/domain/repository/shift_repository.dart';

class ShiftController extends GetxController implements GetxService{
  final ShiftRepository shiftRepository;
  ShiftController({required this.shiftRepository});




  bool isLoading = false;
  ShiftModel? shiftModel;
  Future<void> getShiftList() async {
    Response? response = await shiftRepository.getShiftList();
    if (response?.statusCode == 200) {
      shiftModel = ShiftModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
  ShiftItem? selectedShiftItem;
  void selectShift(ShiftItem item) {
    selectedShiftItem = item;
    update();
  }

  Future<void> createNewShift( String name) async {
    isLoading = true;
    update();
    Response? response = await shiftRepository.createNewShift(name );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getShiftList();

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateShift( String name, int id) async {
    isLoading = true;
    update();
    Response? response = await shiftRepository.updateShift(name, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getShiftList();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteShift(int id) async {
    isLoading = true;
    Response? response = await shiftRepository.deleteShift(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getShiftList();
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
  
  
}