
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/fees_management/waiver/domain/model/waiver_model.dart';
import 'package:mighty_school/feature/fees_management/waiver_config/domain/repository/waiver_config_repository.dart';

class WaiverConfigController extends GetxController implements GetxService{
  final WaiverConfigRepository waiverConfigRepository;
  WaiverConfigController({required this.waiverConfigRepository});

  WaiverModel? waiverModel;
  Future<void> getWaiverAssignList(int page) async {
    Response? response = await waiverConfigRepository.getWaiverAssignListList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        waiverModel = WaiverModel.fromJson(response?.body);
      }else{
        waiverModel?.data?.data?.addAll(WaiverModel.fromJson(response?.body).data!.data!);
        waiverModel?.data?.currentPage = WaiverModel.fromJson(response?.body).data?.currentPage;
        waiverModel?.data?.total = WaiverModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }



  bool isLoading = false;
  

  int waiverConfigTypeIndex = 0;
  void setSelectedWaiverConfigTypeIndex(int typeIndex){
    waiverConfigTypeIndex = typeIndex;
    update();
  }
}