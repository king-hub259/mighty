import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/student_module/student_library/domain/model/student_library_model.dart';
import 'package:mighty_school/feature/student_module/student_library/domain/repository/student_library_repository.dart';

class StudentLibraryController extends GetxController implements GetxService{
  final StudentLibraryRepository libraryRepository;
  StudentLibraryController({required this.libraryRepository});


  StudentLibraryModel? libraryModel;
  Future<void> getLibraryHistory() async {
    Response? response = await libraryRepository.getLibraryHistoryList();
    if(response!.statusCode == 200){
      libraryModel = StudentLibraryModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }

}