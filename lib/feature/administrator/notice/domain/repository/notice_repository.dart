import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/administrator/notice/domain/models/notice_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class NoticeRepository{
  final ApiClient apiClient;
  NoticeRepository({required this.apiClient});


  Future<Response?> getNoticeList(int page) async {
    return await apiClient.getData("${AppConstants.notices}?page=$page&perPage=10");
  }

  Future<Response?> getUserLogList(int page) async {
    return await apiClient.getData("${AppConstants.userLogs}?page=$page&perPage=10");
  }

  Future<Response?> createNewNotice( NoticeBody noticeBody) async {
    return await apiClient.postData(AppConstants.notices, noticeBody.toJson());
  }

  Future<Response?> updateNotice(NoticeBody noticeBody, int id) async {
    return await apiClient.putData("${AppConstants.notices}/$id", noticeBody.toJson());
  }
  

  Future<Response?> deleteNotice (int id) async {
    return await apiClient.deleteData("${AppConstants.notices}/$id");
  }
}