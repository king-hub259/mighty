import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hostel_management/hostel_room_member/domain/model/hostel_room_member_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class HostelRoomMemberRepository {
  final ApiClient apiClient;

  HostelRoomMemberRepository({required this.apiClient});

  Future<Response?> getHostelRoomMembersList(int page) async {
    return await apiClient.getData("${AppConstants.hostelRoomMembers}?per_page=20&page=$page");
  }

  Future<Response?> addNewHostelRoomMember(HostelRoomMemberBody roomMemberBody) async {
    return await apiClient.postData(AppConstants.hostelRoomMembers, roomMemberBody.toJson());
  }

  Future<Response?> updateHostelRoomMember(int id, HostelRoomMemberBody roomMemberBody) async {
    return await apiClient.putData("${AppConstants.hostelRoomMembers}/$id", roomMemberBody.toJson());
  }

  Future<Response?> deleteHostelRoomMember(int id) async {
    return await apiClient.deleteData("${AppConstants.hostelRoomMembers}/$id");
  }

  Future<Response?> getHostelRoomMemberDetails(int id) async {
    return await apiClient.getData("${AppConstants.hostelRoomMembers}/$id");
  }
}
  