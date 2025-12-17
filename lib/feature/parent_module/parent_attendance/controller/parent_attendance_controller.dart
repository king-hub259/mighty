
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/domain/models/attendance_fine_model.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/domain/repository/parent_attendance_repository.dart';

class ParentAttendanceController extends GetxController implements GetxService{
  final ParentAttendanceRepository attendanceRepository;
  ParentAttendanceController({required this.attendanceRepository});


  AttendanceFineModel? attendanceFineModel;
  Future<void> getAttendanceFine() async {
    Response? response = await attendanceRepository.getAttendanceFine();
    if(response!.statusCode == 200){
      attendanceFineModel = AttendanceFineModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

}