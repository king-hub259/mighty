import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/model/banner_body.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/model/banner_model.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/repository/banner_repository.dart';
import 'package:mighty_school/helper/image_size_checker.dart';

class BannerController extends GetxController implements GetxService {
  final BannerRepository bannerRepository;
  BannerController({required this.bannerRepository});

  BannerModel? bannerModel;
  Future<void> getBanner(int page) async {
    Response? response = await bannerRepository.getBanner(page);
    if (response?.statusCode == 200) {
      if (page == 1) {
        bannerModel = BannerModel.fromJson(response?.body);
      }else{
        bannerModel?.data?.data?.addAll(BannerModel.fromJson(response?.body).data?.data??[]);
        bannerModel?.data?.total = BannerModel.fromJson(response?.body).data?.total;
        bannerModel?.data?.currentPage = BannerModel.fromJson(response?.body).data?.currentPage;
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

  bool loading = false;
  Future<void> createBanner(BannerBody body) async {
    loading = true;
    update();
    Response? response = await bannerRepository.createBanner(body, thumbnail);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getBanner(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editBanner(BannerBody body, int id) async {
    loading = true;
    update();
    Response? response = await bannerRepository.editBanner(body, thumbnail, id);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getBanner(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteBanner(int id) async {
    Response? response = await bannerRepository.deleteBanner(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getBanner(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  