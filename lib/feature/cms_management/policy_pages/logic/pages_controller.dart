import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/cms_management/policy_pages/domain/repository/policy_pages_repository.dart';

class PagesController extends GetxController implements GetxService {
  final PagesRepository pagesRepository;
  PagesController({required this.pagesRepository});

  Future<void> getPages() async {
    Response? response = await pagesRepository.getPages();
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  int selectedPageIndex = 0;
  void setSelectedPageIndex(int index) {
    selectedPageIndex = index;
    update();
  }

  Future<void> editPages() async {
    Response? response = await pagesRepository.editPages();
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

}
  