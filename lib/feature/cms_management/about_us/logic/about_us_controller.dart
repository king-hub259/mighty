import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/cms_management/about_us/domain/model/about_us_body.dart';
import 'package:mighty_school/feature/cms_management/about_us/domain/model/about_us_model.dart';
import 'package:mighty_school/feature/cms_management/about_us/domain/repository/about_us_repository.dart';
import 'package:mighty_school/helper/image_size_checker.dart';

class AboutUsController extends GetxController implements GetxService {
  final AboutUsRepository aboutUsRepository;
  AboutUsController({required this.aboutUsRepository});

  AboutUsModel? aboutUsModel;
  Future<void> getAboutUs(int page) async {
    Response? response = await aboutUsRepository.getAboutUs(page);
    if (response?.statusCode == 200) {
      if(page == 1){
        aboutUsModel = AboutUsModel.fromJson(response?.body);
      }else{
        aboutUsModel?.data?.data?.addAll(AboutUsModel.fromJson(response?.body).data!.data!);
        aboutUsModel?.data?.total = AboutUsModel.fromJson(response?.body).data?.total;
        aboutUsModel?.data?.currentPage = AboutUsModel.fromJson(response?.body).data?.currentPage;
      }

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  XFile? thumbnail;
  XFile? pickedImage;
  void pickImage({bool parentIdProof = false}) async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      thumbnail = pickedImage;
    }
    update();
  }

  Future<void> createAboutUs(AboutUsBody body) async {
    Response? response = await aboutUsRepository.createAboutUs(body, thumbnail);
    if (response?.statusCode == 200) {
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAboutUs(1);
      thumbnail = null;
    } else {
      ApiChecker.checkApi(response!);
      
    }
    update();
  }

  Future<void> editAboutUs(AboutUsBody body, int id) async {
    Response? response = await aboutUsRepository.editAboutUs(body, thumbnail, id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAboutUs(1);
      thumbnail = null;
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteAboutUs(int id) async {
    Response? response = await aboutUsRepository.deleteAboutUs(id);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  