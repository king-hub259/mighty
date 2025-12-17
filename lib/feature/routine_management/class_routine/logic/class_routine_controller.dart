
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/routine_management/class_routine/domain/models/classs_routine_model.dart';
import 'package:mighty_school/feature/routine_management/class_routine/domain/repository/class_routine_repository.dart';


class ClassRoutineController extends GetxController implements GetxService{
  final ClassRoutineRepository classRoutineRepository;
  ClassRoutineController({required this.classRoutineRepository});




  bool isLoading = false;
  ClassRoutineModel? classRoutineModel;
  List<DAY>?  sat;
  List<DAY>?  sun;
  List<DAY>?  mon;
  List<DAY>?  tue;
  List<DAY>?  wed;
  List<DAY>?  thu;
  List<DAY>?  fri;
  Future<void> getClassRoutineList(int classId, int sectionId) async {
    Response? response = await classRoutineRepository.getClassRoutine(classId, sectionId);
    if (response?.statusCode == 200) {
      classRoutineModel = ClassRoutineModel.fromJson(response?.body!);
        sat = classRoutineModel?.data?.sATURDAY;
        sun = classRoutineModel?.data?.sUNDAY;
        mon = classRoutineModel?.data?.mONDAY;
        tue = classRoutineModel?.data?.tUESDAY;
        wed = classRoutineModel?.data?.wEDNESDAY;
        thu = classRoutineModel?.data?.tHURSDAY;
        fri = classRoutineModel?.data?.fRIDAY;
      selectDay(getToday());
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  String getToday(){
    DateTime now = DateTime.now();
    return DateFormat('EEEE').format(now);
  }

  String formatTimeToAmPm(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("hh:mm a").format(parsedTime);
  }

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String selectedDay = "Monday";
  void selectDay(String day) {
    selectedDay = day;
    update();
  }

}