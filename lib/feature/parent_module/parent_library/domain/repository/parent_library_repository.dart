import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class ParentLibraryRepository{
  final ApiClient apiClient;
  ParentLibraryRepository({required this.apiClient});

  Future<Response?> getLibraryHistoryList() async {
    return await apiClient.getData(AppConstants.libraryHistory);
  }
}