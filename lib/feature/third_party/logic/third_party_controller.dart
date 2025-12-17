import 'package:get/get.dart';

class ThirdPartyController extends GetxController implements GetxService{
  int thirdPartyType = 0;
  void setThirdPartyType(int val){
    thirdPartyType = val;
    update();
  }
}