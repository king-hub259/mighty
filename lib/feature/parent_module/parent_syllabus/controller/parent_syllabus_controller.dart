
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/parent_module/parent_syllabus/domain/models/parent_syllabus_model.dart';
import 'package:mighty_school/feature/parent_module/parent_syllabus/domain/repository/parent_syllabus_repository.dart';

class ParentSyllabusController extends GetxController implements GetxService{
  final ParentSyllabusRepository syllabusRepository;
  ParentSyllabusController({required this.syllabusRepository});

  bool isLoading = false;
  ParentSyllabusModel? syllabusModel;
  Future<void> getSyllabusList() async {
    Response? response = await syllabusRepository.getSyllabusList();
    if (response?.statusCode == 200) {
      syllabusModel = ParentSyllabusModel.fromJson(response?.body);

      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

}