import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/zoom_class/domain/model/zoom_body.dart';
import 'package:mighty_school/feature/zoom_class/domain/model/zoom_class_model.dart';
import 'package:mighty_school/feature/zoom_class/domain/repository/zoom_class_repository.dart';

class ZoomClassController extends GetxController implements GetxService {
  final ZoomClassRepository zoomClassRepository;
  ZoomClassController({required this.zoomClassRepository});

  ZoomModel? zoomModel;
  Future<void> getZoomClass(int page) async {
    Response? response = await zoomClassRepository.getZoomClass(page);
    if (response?.statusCode == 200) {
      if(page == 1){
        zoomModel = ZoomModel.fromJson(response!.body);
      }else{
        zoomModel?.data?.data?.addAll(ZoomModel.fromJson(response?.body).data!.data!);
        zoomModel?.data?.total = ZoomModel.fromJson(response?.body).data?.total;
        zoomModel?.data?.currentPage = ZoomModel.fromJson(response?.body).data?.currentPage;
      }

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  bool isLoading = false;
  Future<void> createZoomClass(ZoomBody body) async {
    isLoading = true;
    update();
    Response? response = await zoomClassRepository.createZoomClass(body);
    if (response?.statusCode == 200) {
      Get.back();
      showCustomSnackBar("added_successfully", isError: false);
      getZoomClass(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }

  Future<void> editZoomClass(ZoomBody body, int id) async {
    isLoading = true;
    update();
    Response? response = await zoomClassRepository.editZoomClass(body, id);
    if (response?.statusCode == 200) {

      Get.back();
      showCustomSnackBar("updated_successfully", isError: false);
      getZoomClass(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }

  Future<void> deleteZoomClass(int id) async {
    isLoading = true;
    update();
    Response? response = await zoomClassRepository.deleteZoomClass(id);
    if (response?.statusCode == 200) {
      Get.back();
      showCustomSnackBar("deleted_successfully", isError: false);
      getZoomClass(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }


  Future<void> updateZoomConfig(String zoomAccountId, String zoomClientKey, String zoomClientSecret) async {
    isLoading = true;
    update();
    Response? response = await zoomClassRepository.updateZoomClassConfig(zoomAccountId, zoomClientKey, zoomClientSecret);
    if (response?.statusCode == 200) {
      Get.back();
      showCustomSnackBar("updated_successfully", isError: false);
    } else {
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();

  }

}
  