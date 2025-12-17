import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/student_module/student_profile/domain/model/student_profile_model.dart';
import 'package:mighty_school/feature/student_module/student_profile/domain/repository/student_profile_repository.dart';

class StudentProfileController extends GetxController implements GetxService{
  final StudentProfileRepository studentProfileRepository;
  StudentProfileController({required this.studentProfileRepository});


  bool isLoading = false;
  StudentProfileModel? profileModel;
  Future<Response?> getStudentProfileInfo() async {
    isLoading = true;
    Response? response = await studentProfileRepository.getProfileInfo();
    if (response?.statusCode == 200) {
      profileModel = StudentProfileModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
    return response;
  }



}