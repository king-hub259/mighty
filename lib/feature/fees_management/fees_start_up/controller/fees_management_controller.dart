
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/fees_management/fees_start_up/domain/repository/fees_management_repository.dart';

class FeesManagementController extends GetxController implements GetxService{
  final FeesManagementRepository feesManagementRepository;
  FeesManagementController({required this.feesManagementRepository});

  bool isLoading = false;



  Future<void> getStudentQuickCollectionSearch(int classId, int sectionId, int page) async {
    Response? response = await feesManagementRepository.getStudentQuickCollectionSearch(classId, sectionId, page);
    if (response?.statusCode == 200) {


    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> getStudentQuickCollection(int id) async {
    Response? response = await feesManagementRepository.getStudentQuickCollection(id);
    if (response?.statusCode == 200) {
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }






  Future<void> smartCollection(int id) async {
    Response? response = await feesManagementRepository.smartCollection(id);
    if (response?.statusCode == 200) {
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }





  int feesStartupTypeIndex = 0;
  void setSelectedTypeIndex(int typeIndex){
    feesStartupTypeIndex = typeIndex;
    update();
  }


}