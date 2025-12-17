import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/student_module/student_subject/domain/model/student_subject_model.dart';
import 'package:mighty_school/feature/student_module/student_subject/domain/repository/student_subject_repository.dart';


class StudentSubjectController extends GetxController implements GetxService{
  final StudentSubjectRepository subjectRepository;
  StudentSubjectController({required this.subjectRepository});

  StudentSubjectModel? subjectModel;
  Future<void> getMySubjectList() async {
    Response? response = await subjectRepository.getMySubjectList();
    if(response!.statusCode == 200){
      subjectModel = StudentSubjectModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }

}