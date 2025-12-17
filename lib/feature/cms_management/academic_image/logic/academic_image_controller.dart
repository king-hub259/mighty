import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/cms_management/academic_image/domain/model/academic_image_model.dart';
import 'package:mighty_school/feature/cms_management/academic_image/domain/repository/academic_image_repository.dart';

class AcademicImageController extends GetxController implements GetxService {
  final AcademicImageRepository academicImageRepository;
  AcademicImageController({required this.academicImageRepository});

  AcademicImageModel? academicImageModel;
  Future<void> getAcademicImage(int page) async {
    Response? response = await academicImageRepository.getAcademicImage(page);
    if (response?.statusCode == 200) {
      if(page == 1) {
        academicImageModel = AcademicImageModel.fromJson(response?.body);
      }else{
        academicImageModel?.data?.data?.addAll(AcademicImageModel.fromJson(response?.body).data?.data ?? []);
        academicImageModel?.data?.total = AcademicImageModel.fromJson(response?.body).data?.total;
        academicImageModel?.data?.currentPage = AcademicImageModel.fromJson(response?.body).data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  XFile? thumbnail;
  XFile? pickedImage;
  Future<void> pickImage() async {
    thumbnail = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (thumbnail != null) {
      pickedImage = thumbnail;
      update();
    }
  }


  bool loading = false;
  Future<void> createAcademicImage(String title) async {
    loading = true;
    update();
    Response? response = await academicImageRepository.createAcademicImage(title, thumbnail);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAcademicImage(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editAcademicImage(String title, int id) async {
    loading = true;
    update();
    Response? response = await academicImageRepository.editAcademicImage(title, thumbnail, id);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAcademicImage(1);
      
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteAcademicImage(int id) async {
    Response? response = await academicImageRepository.deleteAcademicImage(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAcademicImage(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  