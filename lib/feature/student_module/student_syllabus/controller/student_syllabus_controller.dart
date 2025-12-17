
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/student_module/student_syllabus/domain/models/student_syllabus_model.dart';
import 'package:mighty_school/feature/student_module/student_syllabus/domain/repository/student_syllabus_repository.dart';

class StudentSyllabusController extends GetxController implements GetxService{
  final StudentSyllabusRepository syllabusRepository;
  StudentSyllabusController({required this.syllabusRepository});


  StudentSyllabusModel? syllabusModel;
  Future<void> getSyllabusList() async {
    Response? response = await syllabusRepository.getSyllabusList();
    if (response?.statusCode == 200) {
      syllabusModel = StudentSyllabusModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

}