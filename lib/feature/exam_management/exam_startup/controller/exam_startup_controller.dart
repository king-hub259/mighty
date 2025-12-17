import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_assign_store_body.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_code_store_body.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_grade_model.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_grade_store_body.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_short_code_model.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/merit_process_type_model.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/repository/exam_startup_repository.dart';

class ExamStartupController extends GetxController implements GetxService{
  final ExamStartupRepository examStartupRepository;
  ExamStartupController({required this.examStartupRepository});

  ExamShortCodeModel? examShortCodeModel;
  Future<void> getExamShortCodeList(int page) async {
    Response? response = await examStartupRepository.getExamShortCodeList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        examShortCodeModel = ExamShortCodeModel.fromJson(response?.body);
      }else{
        examShortCodeModel?.data?.data?.addAll(ExamShortCodeModel.fromJson(response?.body).data!.data!);
        examShortCodeModel?.data?.currentPage = ExamShortCodeModel.fromJson(response?.body).data?.currentPage;
        examShortCodeModel?.data?.total = ExamShortCodeModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  ExamGradeModel? examGradeModel;
  Future<void> getExamGradeList(int page) async {
    Response? response = await examStartupRepository.getExamGradeList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        examGradeModel = ExamGradeModel.fromJson(response?.body);
      }else{
        examGradeModel?.data?.data?.addAll(ExamGradeModel.fromJson(response?.body).data!.data!);
        examGradeModel?.data?.currentPage = ExamGradeModel.fromJson(response?.body).data?.currentPage;
        examGradeModel?.data?.total = ExamGradeModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }






  bool isLoading = false;

  bool isAllGradeSelected = false;
  void toggleAllGradeSelected(){
    isAllGradeSelected =!isAllGradeSelected;
    examGradeModel?.data?.data?.forEach((exam) => exam.isSelected = isAllGradeSelected);
    addSelectedGrade();
    update();
  }

  void toggleExamGrade(int index){
    examGradeModel?.data?.data![index].isSelected =!examGradeModel!.data!.data![index].isSelected!;
    addSelectedGrade();
    update();
  }

  List<ExamGradeItem> selectedGradeList = [];

  void addSelectedGrade(){
    selectedGradeList = [];
    examGradeModel?.data?.data?.forEach((grade) {
      if(grade.isSelected == true){
        selectedGradeList.add(grade);
      }
    });
    update();
  }


  MeritProcessTypeItem? selectedMeritProcessType;
  int? selectedMeritTypeIndex;
  void toggleMeritProcessType(int index){
    selectedMeritTypeIndex = index;
    selectedMeritProcessType = meritProcessTypeModel?.data?.data![index];
    //only 1 item can be selected
    meritProcessTypeModel?.data?.data?.forEach((type) {
      if(type.isSelected == true && type.id != selectedMeritProcessType?.id){
        type.isSelected = false;
      }
    });
    meritProcessTypeModel?.data?.data![index].isSelected =!meritProcessTypeModel!.data!.data![index].isSelected!;
    update();
  }




  List<ExamShortCodeItem> selectedCodeList = [];
  bool isAllSelected = false;
  void toggleAllSelection(){
    selectedCodeList = [];
    isAllSelected =!isAllSelected;
    examShortCodeModel?.data?.data?.forEach((exam) => exam.isSelected = isAllSelected);
    examShortCodeModel?.data?.data?.forEach((code) {
      if(code.isSelected == true){
        selectedCodeList.add(code);
      }
    });
    update();
  }
  void toggleSelection(int index){
    selectedCodeList = [];
    examShortCodeModel?.data?.data![index].isSelected =!(examShortCodeModel!.data!.data![index].isSelected??false);
    examShortCodeModel?.data?.data?.forEach((code) {
      if(code.isSelected == true){
        selectedCodeList.add(code);
      }
    });
    update();
  }



  int examStartupTypeIndex = 0;
  void setSelectedTypeIndex(int typeIndex){
    examStartupTypeIndex = typeIndex;
    update();
  }


  MeritProcessTypeModel? meritProcessTypeModel;
  Future<void> getMeritProcessTypeList(int page) async {
    Response? response = await examStartupRepository.getMeritProcessTypeList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        meritProcessTypeModel = MeritProcessTypeModel.fromJson(response?.body);
      }else{
        meritProcessTypeModel?.data?.data?.addAll(MeritProcessTypeModel.fromJson(response?.body).data!.data!);
        meritProcessTypeModel?.data?.currentPage = MeritProcessTypeModel.fromJson(response?.body).data?.currentPage;
        meritProcessTypeModel?.data?.total = MeritProcessTypeModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  Future<void> examCodeStore(ExamCodeStoreBody body) async {
    isLoading = true;
    update();
    Response? response = await examStartupRepository.examCodeStore(body);
    if(response?.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("store_successfully".tr, isError: false);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }

  Future<void> examGradeStore(ExamGradeStoreBody body) async {
    isLoading = true;
    update();
    Response? response = await examStartupRepository.examGradeStore(body);
    if(response?.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("store_successfully".tr, isError: false);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }

  Future<void> examAssignStore(ExamAssignStoreBody body) async {
    isLoading = true;
    update();
    Response? response = await examStartupRepository.examAssignStore(body);
    if(response?.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("store_successfully".tr);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }

}