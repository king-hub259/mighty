
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/administrator/notice/domain/models/notice_model.dart';
import 'package:mighty_school/feature/parent_module/parent_notice/domain/repository/parent_notice_repository.dart';

class ParentNoticeController extends GetxController implements GetxService{
  final ParentNoticeRepository noticeRepository;
  ParentNoticeController({required this.noticeRepository});




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