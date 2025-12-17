
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/administrator/notice/domain/models/notice_model.dart';
import 'package:mighty_school/feature/student_module/student_notice/domain/repository/student_notice_repository.dart';

class StudentNoticeController extends GetxController implements GetxService{
  final StudentNoticeRepository noticeRepository;
  StudentNoticeController({required this.noticeRepository});




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
  
}