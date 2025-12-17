import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/parent_module/parent_subject/domain/model/children_subject_model.dart';
import 'package:mighty_school/feature/parent_module/parent_subject/domain/repository/parent_subject_repository.dart';

class ParentSubjectController extends GetxController implements GetxService{
  final ParentSubjectRepository subjectRepository;
  ParentSubjectController({required this.subjectRepository});


  ChildrenSubjectsModel? childrenSubjectsModel;
  Future<void> getChildrenSubjects() async {
    Response? response = await subjectRepository.getChildrenSubjects();
    if(response!.statusCode == 200){
      childrenSubjectsModel = ChildrenSubjectsModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }



}