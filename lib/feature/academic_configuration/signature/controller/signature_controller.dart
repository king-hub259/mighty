
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/controller/pick_image_controller.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/signature/domain/models/signature_list_model.dart';
import 'package:mighty_school/feature/academic_configuration/signature/domain/repository/signature_repository.dart';

class SignatureController extends GetxController implements GetxService{
  final SignatureRepository signatureRepository;
  SignatureController({required this.signatureRepository});


  bool isLoading = false;
  SignatureModel? signatureModel;
  Future<void> getSignatureList(int offset) async {
    Response? response = await signatureRepository.getSignatureList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        signatureModel = SignatureModel.fromJson(response?.body);
      }else{
        signatureModel?.data?.data?.addAll(SignatureModel.fromJson(response?.body).data!.data!);
        signatureModel?.data?.currentPage = SignatureModel.fromJson(response?.body).data?.currentPage;
        signatureModel?.data?.total = SignatureModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }




  Future<void> createNewSignature( String name, String description,) async {
    isLoading = true;
    update();
    Response? response = await signatureRepository.createNewSignature(name, description, Get.find<PickImageController>().thumbnail);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getSignatureList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateSignature( String name, String description, int id) async {
    isLoading = true;
    update();
    Response? response = await signatureRepository.updateSignature(name, description, Get.find<PickImageController>().thumbnail,id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getSignatureList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteSignature(int id) async {
    isLoading = true;
    Response? response = await signatureRepository.deleteSignature(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getSignatureList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
}