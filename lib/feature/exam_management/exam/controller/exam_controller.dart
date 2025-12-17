import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/repository/exam_repository.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/model/exam_model.dart';


class ExamController extends GetxController implements GetxService{
  final ExamRepository examRepository;
  ExamController({required this.examRepository});


  ExamModel? examModel;
  Future<void> getExamList(int page) async {
    Response? response = await examRepository.examList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        examModel = ExamModel.fromJson(response?.body);
      }else{
        examModel?.data?.data?.addAll(ExamModel.fromJson(response?.body).data!.data!);
        examModel?.data?.currentPage = ExamModel.fromJson(response?.body).data?.currentPage;
        examModel?.data?.total = ExamModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  ExamItem? selectedExamItem;
  void selectExam(ExamItem exam){
    selectedExamItem = exam;
    update();
  }




  List<ExamItem> selectedExamList = [];
  void addSelectedExam(){
    examModel?.data?.data?.forEach((exam) {
      if(exam.isSelected == true){
        selectedExamList.add(exam);
      }
    });
    update();
  }
  void removeSelectedExam(int index){
    selectedExamList.removeAt(index);
    update();
  }


  void toggleExam(int index){
    examModel?.data?.data![index].isSelected =!examModel!.data!.data![index].isSelected!;
    update();
  }

  bool isLoading = false;
  Future<void> addNewExam(String name) async {
    isLoading = true;
    update();
    Response? response = await examRepository.addNewExam(name);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getExamList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateExam(String name, int id) async {
    isLoading = true;
    update();
    Response? response = await examRepository.examEdit(name, id);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getExamList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteExam(int id) async {
    Response? response = await examRepository.deleteExam(id);
    if(response?.statusCode == 200){
      getExamList(1);
      showCustomSnackBar("deleted_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


}