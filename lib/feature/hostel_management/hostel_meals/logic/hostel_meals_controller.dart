import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/model/hostel_meal_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/repository/hostel_meals_repository.dart';

class HostelMealsController extends GetxController implements GetxService {
  final HostelMealsRepository hostelMealsRepository;
  HostelMealsController({required this.hostelMealsRepository});


  ApiResponse<HostelMealItem>? hostelMealModel;
  Future<void> getHostelMeals(int page) async {
    Response? response = await hostelMealsRepository.getHostelMealsList(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<HostelMealItem>.fromJson(response?.body, (data) => HostelMealItem.fromJson(data));

      if(page ==1){
        hostelMealModel = apiResponse;
      }else{
        hostelMealModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        hostelMealModel?.data?.total = apiResponse.data?.total;
        hostelMealModel?.data?.currentPage = apiResponse.data?.currentPage;
      }

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createHostelMeals(HostelMealBody mealBody) async {
    Response? response = await hostelMealsRepository.addNewHostelMeal(mealBody);
    if (response?.statusCode == 200) {
      showCustomSnackBar("added_successfully".tr, isError: false);
      getHostelMeals(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editHostelMeals(int id, HostelMealBody mealBody) async {
    Response? response = await hostelMealsRepository.updateHostelMeal(id, mealBody);
    if (response?.statusCode == 200) {
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getHostelMeals(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteHostelMeals(int id) async {
    Response? response = await hostelMealsRepository.deleteHostelMeal(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getHostelMeals(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  