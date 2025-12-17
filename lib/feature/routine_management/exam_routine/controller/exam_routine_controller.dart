
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/domain/model/exam_routine_body.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/domain/model/exam_routine_model.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/domain/repository/exam_routine_repository.dart';

class ExamRoutineController extends GetxController implements GetxService{
  final ExamRoutineRepository examRoutineRepository;
  ExamRoutineController({required this.examRoutineRepository});

  ExamRoutineModel? examRoutineModel;
  Future<void> getExamRoutineList(int classId, int examId) async {
    Response? response = await examRoutineRepository.getExamRoutineList(classId, examId);
    if(response?.statusCode == 200){
      examRoutineModel = ExamRoutineModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }



  bool isLoading = false;
  Future<void> storeExamRoutine(ExamRoutineBody body) async {
    isLoading = true;
    update();
    Response? response = await examRoutineRepository.storeExamRoutine(body);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr.tr, isError: false);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }


}