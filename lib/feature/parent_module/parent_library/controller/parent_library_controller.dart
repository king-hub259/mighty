import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/parent_module/parent_library/domain/model/library_history_model.dart';
import 'package:mighty_school/feature/parent_module/parent_library/domain/repository/parent_library_repository.dart';

class ParentLibraryController extends GetxController implements GetxService{
  final ParentLibraryRepository libraryRepository;
  ParentLibraryController({required this.libraryRepository});

  LibraryHistoryModel? libraryHistoryModel;
  Future<void> getLibraryHistoryList() async {
    Response? response = await libraryRepository.getLibraryHistoryList();
    if(response!.statusCode == 200){
      libraryHistoryModel = LibraryHistoryModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


}