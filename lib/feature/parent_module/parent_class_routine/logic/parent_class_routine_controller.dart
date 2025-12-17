
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/domain/models/parent_classs_routine_model.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/domain/repository/parent_class_routine_repository.dart';


class ParentClassRoutineController extends GetxController implements GetxService{
  final ParentClassRoutineRepository classRoutineRepository;
  ParentClassRoutineController({required this.classRoutineRepository});




  bool isLoading = false;
  ParentClassRoutineModel? classRoutineModel;
  List<RoutineDetails>?  sat;
  List<RoutineDetails>?  sun;
  List<RoutineDetails>?  mon;
  List<RoutineDetails>?  tue;
  List<RoutineDetails>?  wed;
  List<RoutineDetails>?  thu;
  List<RoutineDetails>?  fri;
  Future<void> getClassRoutineList() async {
    Response? response = await classRoutineRepository.getClassRoutine();
    if (response?.statusCode == 200) {
      classRoutineModel = ParentClassRoutineModel.fromJson(response?.body!);
        sat = classRoutineModel?.data?.routine?.saturday;
        sun = classRoutineModel?.data?.routine?.sunday;
        mon = classRoutineModel?.data?.routine?.monday;
        tue = classRoutineModel?.data?.routine?.tuesday;
        wed = classRoutineModel?.data?.routine?.wednesday;
        thu = classRoutineModel?.data?.routine?.thursday;
        fri = classRoutineModel?.data?.routine?.friday;
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