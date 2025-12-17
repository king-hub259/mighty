import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/domain/repository/hostel_meal_plan_repository.dart';

class HostelMealPlanController extends GetxController implements GetxService {
  final HostelMealPlanRepository hostelMealPlanRepository;
  HostelMealPlanController({required this.hostelMealPlanRepository});

  ApiResponse<HostelMealPlanItem>? hostelMealPlanModel;
  Future<void> getHostelMealPlan(int page) async {
    Response? response = await hostelMealPlanRepository.getHostelMealPlansList(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<HostelMealPlanItem>.fromJson(response?.body, (json) => HostelMealPlanItem.fromJson(json));

      if(page ==1){
        hostelMealPlanModel = apiResponse;
      }else{
        hostelMealPlanModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        hostelMealPlanModel?.data?.total = apiResponse.data?.total;
        hostelMealPlanModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createHostelMealPlan(HostelMealPlanBody mealPlanBody) async {
    Response? response = await hostelMealPlanRepository.addNewHostelMealPlan(mealPlanBody);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editHostelMealPlan(int id, HostelMealPlanBody mealPlanBody) async {
    Response? response = await hostelMealPlanRepository.updateHostelMealPlan(id, mealPlanBody);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteHostelMealPlan(int id) async {
    Response? response = await hostelMealPlanRepository.deleteHostelMealPlan(id);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  