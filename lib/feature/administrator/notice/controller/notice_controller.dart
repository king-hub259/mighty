
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/administrator/notice/domain/models/notice_body.dart';
import 'package:mighty_school/feature/administrator/notice/domain/models/notice_model.dart';
import 'package:mighty_school/feature/administrator/notice/domain/models/user_log_model.dart';
import 'package:mighty_school/feature/administrator/notice/domain/repository/notice_repository.dart';

class NoticeController extends GetxController implements GetxService{
  final NoticeRepository noticeRepository;
  NoticeController({required this.noticeRepository});




  bool isLoading = false;
  NoticeModel? noticeModel;
  Future<void> getNoticeList(int offset) async {
    Response? response = await noticeRepository.getNoticeList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        noticeModel = NoticeModel.fromJson(response?.body);
      }else{
        noticeModel?.data?.data?.addAll(NoticeModel.fromJson(response?.body).data!.data!);
        noticeModel?.data?.currentPage = NoticeModel.fromJson(response?.body).data?.currentPage;
        noticeModel?.data?.total = NoticeModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  UserLogModel? userLogModel;
  Future<void> getUserLogList(int offset) async {
    Response? response = await noticeRepository.getUserLogList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        userLogModel = UserLogModel.fromJson(response?.body);
      }else{
        userLogModel?.data?.data?.addAll(UserLogModel.fromJson(response?.body).data!.data!);
        userLogModel?.data?.currentPage = UserLogModel.fromJson(response?.body).data?.currentPage;
        userLogModel?.data?.total = UserLogModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  List<String> noticeTypes = [
    'Website',
    'Student',
    'Parent',
    'Teacher',
    'Accountant',
    'Librarian',
    'Employee',
    'Admin',
  ];


  List<String> selectedTypes = [];
  void toggleType(String type) {
    if (selectedTypes.contains(type)) {
      selectedTypes.remove(type);
    } else {
      selectedTypes.add(type);
    }
    update();
  }


  Future<void> createNewNotice(NoticeBody noticeBody) async {
    isLoading = true;
    update();
    Response? response = await noticeRepository.createNewNotice(noticeBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getNoticeList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateNotice(NoticeBody noticeBody, int id) async {
    isLoading = true;
    update();
    Response? response = await noticeRepository.updateNotice(noticeBody, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getNoticeList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteNotice(int id) async {
    isLoading = true;
    Response? response = await noticeRepository.deleteNotice(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getNoticeList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
}