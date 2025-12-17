import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/util/app_constants.dart';

class LandingPageRepository {
  final ApiClient apiClient;
  LandingPageRepository({required this.apiClient});

  Future<Response> getLandingPageData() async {
    return await apiClient.getData(AppConstants.banner);
  }

  Future<Response> getSubscriptionPackageList() async {
    return await apiClient.getData("${AppConstants.subscriptionPackageList}?perPage=100&page=1");
  }

  Future<Response> getSaasFaqData() async {
    return await apiClient.getData("${AppConstants.publicSaasFaqs}?limit=100&page=1");
  }


}
