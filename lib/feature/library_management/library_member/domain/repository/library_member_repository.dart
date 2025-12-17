import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class LibraryMemberRepository{
  final ApiClient apiClient;
  LibraryMemberRepository({required this.apiClient});

  Future<Response?> getMemberList(int page) async {
    return await apiClient.getData("${AppConstants.getLibraryMember}?per_page=30&page=$page");
  }



}