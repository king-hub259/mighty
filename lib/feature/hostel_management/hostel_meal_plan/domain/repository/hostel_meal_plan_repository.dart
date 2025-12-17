import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class HostelMealPlanRepository {
  final ApiClient apiClient;

  HostelMealPlanRepository({required this.apiClient});

  Future<Response?> getHostelMealPlansList(int page) async {
    return await apiClient.getData("${AppConstants.hostelMealPlan}?per_page=20&page=$page");
  }

  Future<Response?> addNewHostelMealPlan(HostelMealPlanBody mealPlanBody) async {
    return await apiClient.postData(AppConstants.hostelMealPlan, mealPlanBody.toJson());
  }

  Future<Response?> updateHostelMealPlan(int id, HostelMealPlanBody mealPlanBody) async {
    return await apiClient.putData("${AppConstants.hostelMealPlan}/$id", mealPlanBody.toJson());
  }

  Future<Response?> deleteHostelMealPlan(int id) async {
    return await apiClient.deleteData("${AppConstants.hostelMealPlan}/$id");
  }

  Future<Response?> getHostelMealPlanDetails(int id) async {
    return await apiClient.getData("${AppConstants.hostelMealPlan}/$id");
  }
}
  