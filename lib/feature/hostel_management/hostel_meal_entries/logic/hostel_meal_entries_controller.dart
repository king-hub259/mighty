import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/domain/repository/hostel_meal_entries_repository.dart';

class HostelMealEntriesController extends GetxController implements GetxService {
  final HostelMealEntriesRepository hostelMealEntriesRepository;
  HostelMealEntriesController({required this.hostelMealEntriesRepository});

  ApiResponse<HostelMealEntryItem>? mealEntryModel;
  Future<void> getHostelMealEntries(int page) async {
    Response? response = await hostelMealEntriesRepository.getHostelMealEntriesList(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<HostelMealEntryItem>.fromJson(response?.body, (json) => HostelMealEntryItem.fromJson(json));
     if(page ==1) {
       mealEntryModel = apiResponse;
     }else{
       mealEntryModel?.data?.data?.addAll(apiResponse.data?.data??[]);
       mealEntryModel?.data?.total = apiResponse.data?.total;
       mealEntryModel?.data?.currentPage = apiResponse.data?.currentPage;
     }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createHostelMealEntries(HostelMealEntryBody mealEntryBody) async {
    Response? response = await hostelMealEntriesRepository.addNewHostelMealEntry(mealEntryBody);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editHostelMealEntries(int id, HostelMealEntryBody mealEntryBody) async {
    Response? response = await hostelMealEntriesRepository.updateHostelMealEntry(id, mealEntryBody);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteHostelMealEntries(int id) async {
    Response? response = await hostelMealEntriesRepository.deleteHostelMealEntry(id);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  