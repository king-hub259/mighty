import 'package:get/get.dart';

class IdCardController extends GetxController implements GetxService{

  int idTypeIndex = 0;
  void setSelectedIdTypeIndex(int typeIndex){
    idTypeIndex = typeIndex;
    update();
  }

}