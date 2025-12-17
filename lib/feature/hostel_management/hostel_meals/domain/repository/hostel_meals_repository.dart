import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/model/hostel_meal_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class HostelMealsRepository {
  final ApiClient apiClient;

  HostelMealsRepository({required this.apiClient});

  Future<Response?> getHostelMealsList(int page) async {
    return await apiClient.getData("${AppConstants.hostelMeals}?per_page=20&page=$page");
  }

  Future<Response?> addNewHostelMeal(HostelMealBody mealBody) async {
    return await apiClient.postData(AppConstants.hostelMeals, mealBody.toJson());
  }

  Future<Response?> updateHostelMeal(int id, HostelMealBody mealBody) async {
    return await apiClient.putData("${AppConstants.hostelMeals}/$id", mealBody.toJson());
  }

  Future<Response?> deleteHostelMeal(int id) async {
    return await apiClient.deleteData("${AppConstants.hostelMeals}/$id");
  }

  Future<Response?> getHostelMealDetails(int id) async {
    return await apiClient.getData("${AppConstants.hostelMeals}/$id");
  }
}
  