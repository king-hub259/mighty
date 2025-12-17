import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/domain/model/hostel_member_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class HostelMembersRepository {
  final ApiClient apiClient;

  HostelMembersRepository({required this.apiClient});

  Future<Response?> getHostelMembersList(int page) async {
    return await apiClient.getData("${AppConstants.hostelMembers}?per_page=20&page=$page");
  }

  Future<Response?> addNewHostelMember(HostelMemberBody memberBody) async {
    return await apiClient.postData(AppConstants.hostelMembers, memberBody.toJson());
  }

  Future<Response?> updateHostelMember(int id, HostelMemberBody memberBody) async {
    return await apiClient.putData("${AppConstants.hostelMembers}/$id", memberBody.toJson());
  }

  Future<Response?> deleteHostelMember(int id) async {
    return await apiClient.deleteData("${AppConstants.hostelMembers}/$id");
  }

  Future<Response?> getHostelMemberDetails(int id) async {
    return await apiClient.getData("${AppConstants.hostelMembers}/$id");
  }
}
  