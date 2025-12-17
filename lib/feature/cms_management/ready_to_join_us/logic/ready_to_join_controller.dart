import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/domain/model/ready_to_join_body.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/domain/model/ready_to_join_model.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/domain/repository/ready_to_join_repository.dart';
import 'package:mighty_school/helper/image_size_checker.dart';

class ReadyToJoinController extends GetxController implements GetxService {
  final ReadyToJoinRepository readyToJoinRepository;
  ReadyToJoinController({required this.readyToJoinRepository});

  ApiResponse<ReadyToJoinItem>? readyToJoinModel;
  Future<void> getReadyToJoin(int page) async {
    Response? response = await readyToJoinRepository.getReadyToJoin(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<ReadyToJoinItem>.fromJson(
        response?.body,
            (json) => ReadyToJoinItem.fromJson(json),
      );
      if (page == 1) {
        readyToJoinModel = apiResponse;
      }else{
        readyToJoinModel?.data?.data?.addAll(apiResponse.data?.data??[]);
        readyToJoinModel?.data?.total = apiResponse.data?.total;
        readyToJoinModel?.data?.currentPage = apiResponse.data?.currentPage;
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
  Future<void> createReadyToJoin(ReadyToJoinBody body) async {
    loading = true;
    update();
    Response? response = await readyToJoinRepository.createReadyToJoin(body, thumbnail);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getReadyToJoin(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editReadyToJoin(ReadyToJoinBody body, int id) async {
    loading = true;
    update();
    Response? response = await readyToJoinRepository.editReadyToJoin(body, thumbnail, id);
    if (response?.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getReadyToJoin(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteReadyToJoin(int id) async {
    Response? response = await readyToJoinRepository.deleteReadyToJoin(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getReadyToJoin(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  