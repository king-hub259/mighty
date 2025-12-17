import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/model/mobile_app_body.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/model/mobile_app_model.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/repository/mobile_app_repository.dart';
import 'package:mighty_school/helper/image_size_checker.dart';

class MobileAppController extends GetxController implements GetxService {
  final MobileAppRepository mobileAppRepository;
  MobileAppController({required this.mobileAppRepository});


  ApiResponse<MobileAppItem>? mobileAppModel;
  Future<void> getMobileApp(int page) async {
    Response? response = await mobileAppRepository.getMobileApp(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<MobileAppItem>.fromJson(response!.body, (data) => MobileAppItem.fromJson(data));
      if(page == 1) {
        mobileAppModel = apiResponse;
      }else{
        mobileAppModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        mobileAppModel?.data?.total = apiResponse.data?.total;
        mobileAppModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool loading = false;
  Future<void> createMobileApp(MobileAppBody body) async {
    loading = true;
    update();
    Response? response = await mobileAppRepository.createMobileApp(body, thumbnail);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getMobileApp(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editMobileApp(MobileAppBody body, int id) async {
    loading = true;
    update();
    Response? response = await mobileAppRepository.editMobileApp(body, thumbnail, id);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getMobileApp(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteMobileApp(int id) async {
    Response? response = await mobileAppRepository.deleteMobileApp(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getMobileApp(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  XFile? thumbnail;
  XFile? pickedImage;
  void pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      thumbnail = pickedImage;
    }}
    update();
  }
}
  