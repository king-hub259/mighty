import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/domain/model/why_choose_us_model.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/domain/repository/why_choose_us_repository.dart';
import 'package:mighty_school/helper/image_size_checker.dart';

class WhyChooseUsController extends GetxController implements GetxService {
  final WhyChooseUsRepository whyChooseUsRepository;
  WhyChooseUsController({required this.whyChooseUsRepository});

  ApiResponse<WhyChooseUsItem>? whyChooseUsModel;
  Future<void> getWhyChooseUs(int page) async {
    Response? response = await whyChooseUsRepository.getWhyChooseUs(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<WhyChooseUsItem>.fromJson(
        response?.body,
        (json) => WhyChooseUsItem.fromJson(json),
      );
      if(page == 1) {
        whyChooseUsModel = apiResponse;
      } else {
        whyChooseUsModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        whyChooseUsModel?.data?.total = apiResponse.data?.total;
        whyChooseUsModel?.data?.currentPage = apiResponse.data?.currentPage;
      }

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  XFile? benefitImage;
  XFile? pickedImage;
  void pickImage({bool parentIdProof = false}) async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      benefitImage = pickedImage;
    }
    update();
  }
  bool loading = false;
  Future<void> createWhyChooseUs(String title, String description) async {
    loading = true;
    update();
    Response? response = await whyChooseUsRepository.createWhyChooseUs(title, description, benefitImage);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getWhyChooseUs(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
  Future<void> editWhyChooseUs(String title, String description, int id) async {
    loading = true;
    update();
    Response? response = await whyChooseUsRepository.editWhyChooseUs(title, description, benefitImage, id);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getWhyChooseUs(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteWhyChooseUs(int id) async {
    Response? response = await whyChooseUsRepository.deleteWhyChooseUs(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getWhyChooseUs(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  