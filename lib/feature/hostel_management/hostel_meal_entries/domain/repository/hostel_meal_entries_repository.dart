import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class HostelMealEntriesRepository {
  final ApiClient apiClient;

  HostelMealEntriesRepository({required this.apiClient});

  Future<Response?> getHostelMealEntriesList(int page) async {
    return await apiClient.getData("${AppConstants.hostelMealEntries}?per_page=20&page=$page");
  }

  Future<Response?> addNewHostelMealEntry(HostelMealEntryBody mealEntryBody) async {
    return await apiClient.postData(AppConstants.hostelMealEntries, mealEntryBody.toJson());
  }

  Future<Response?> updateHostelMealEntry(int id, HostelMealEntryBody mealEntryBody) async {
    return await apiClient.putData("${AppConstants.hostelMealEntries}/$id", mealEntryBody.toJson());
  }

  Future<Response?> deleteHostelMealEntry(int id) async {
    return await apiClient.deleteData("${AppConstants.hostelMealEntries}/$id");
  }

  Future<Response?> getHostelMealEntryDetails(int id) async {
    return await apiClient.getData("${AppConstants.hostelMealEntries}/$id");
  }
}
  