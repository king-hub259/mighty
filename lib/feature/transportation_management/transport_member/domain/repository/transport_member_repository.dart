import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/domain/model/transport_member_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class TransportMemberRepository {
  final ApiClient apiClient;

  TransportMemberRepository({required this.apiClient});

  Future<Response?> getTransportMemberList(int page) async {
    return await apiClient.getData("${AppConstants.transportMembers}?per_page=20&page=$page");
  }

  Future<Response?> createTransportMember(TransportMemberBody transportMemberBody) async {
    return await apiClient.postData(AppConstants.transportMembers, transportMemberBody.toJson());
  }

  Future<Response?> getTransportMemberDetails(int id) async {
    return await apiClient.getData("${AppConstants.transportMembers}/$id");
  }

  Future<Response?> updateTransportMember(TransportMemberBody transportMemberBody, int id) async {
    return await apiClient.postData("${AppConstants.transportMembers}/$id", {
      ...transportMemberBody.toJson(),
      "_method": "PUT"
    });
  }

  Future<Response?> deleteTransportMember(int id) async {
    return await apiClient.deleteData("${AppConstants.transportMembers}/$id");
  }
}
  