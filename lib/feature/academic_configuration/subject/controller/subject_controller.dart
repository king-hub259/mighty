import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/model/class_wise_subject_model.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/model/subject_body.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/repository/subject_repository.dart';

class SubjectController extends GetxController implements GetxService{
  final SubjectRepository subjectRepository;
  SubjectController({required this.subjectRepository});

  ClassWiseSubjectModel? classWiseSubjectModel;
  Future<void> getClassWiseSubjectList(int classId) async {
    Response? response = await subjectRepository.getClassWiseSubjectList(classId);
    if(response!.statusCode == 200){
      classWiseSubjectModel = ClassWiseSubjectModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }

  SubjectItem? selectedSubjectItem;
  void setSelectSubjectItem(SubjectItem? sectionItem){
    selectedSubjectItem = sectionItem;
    update();
  }

  SubjectModel? subjectModel;
  Future<void> getSubjectList(int page) async {
    Response? response = await subjectRepository.getSubjectList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        subjectModel = SubjectModel.fromJson(response?.body);
      }else{
        subjectModel?.data?.data?.addAll(SubjectModel.fromJson(response?.body).data!.data!);
        subjectModel?.data?.currentPage = SubjectModel.fromJson(response?.body).data?.currentPage;
        subjectModel?.data?.total = SubjectModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  void toggleSelectSubject(int index){
    if(subjectModel?.data?.data![index].isSelected == true){
      subjectModel?.data?.data![index].isSelected = false;
    }else{
      subjectModel?.data?.data![index].isSelected = true;
    }
    update();
  }



  bool isLoading = false;
  Future<void> addNewSubject (SubjectBody subjectBody) async {
    isLoading = true;
    update();
    Response? response = await subjectRepository.addNewSubject(subjectBody);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getSubjectList(1);
    }
    else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }


  Future<void> updateSubject (int subjectId, SubjectBody subjectBody) async {
    Response? response = await subjectRepository.updateSubject(subjectBody, subjectId);
    if(response!.statusCode == 200){
      showCustomSnackBar("updated_successfully".tr);
      getSubjectList(1);
    }
    else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> deleteSubject (int subjectId) async {
    Response? response = await subjectRepository.deleteSubject(subjectId);
    if(response!.statusCode == 200){
      showCustomSnackBar("deleted_successfully".tr);
      getSubjectList(1);
    }
    else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  List<String> subjectTypes = ["Compulsory", "Optional"];
  String selectedType = "Compulsory";
  void setSubjectType(String type){
    selectedType = type;
    update();
  }

  List<String> subjectTypeForms = ["All Groups","Compulsory", "Elective", "Optional"];
  String selectedTypeForm = "All Groups";
  void setSubjectTypeForm(String type){
    selectedTypeForm = type;
    update();
  }



}