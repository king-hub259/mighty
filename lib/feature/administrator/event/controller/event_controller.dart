
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/controller/pick_image_controller.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/administrator/event/domain/models/event_body.dart';
import 'package:mighty_school/feature/administrator/event/domain/models/event_model.dart';
import 'package:mighty_school/feature/administrator/event/domain/repository/event_repository.dart';

class EventController extends GetxController implements GetxService{
  final EventRepository eventRepository;
  EventController({required this.eventRepository});




  bool isLoading = false;
  EventModel? eventModel;
  Future<void> getEventList(int offset) async {
    Response? response = await eventRepository.getEventList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        eventModel = EventModel.fromJson(response?.body);
      }else{
        eventModel?.data?.data?.addAll(EventModel.fromJson(response?.body).data!.data!);
        eventModel?.data?.currentPage = EventModel.fromJson(response?.body).data?.currentPage;
        eventModel?.data?.total = EventModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  Future<void> createNewEvent(EventBody eventBody) async {
    isLoading = true;
    update();
    Response? response = await eventRepository.createNewEvent(eventBody, Get.find<PickImageController>().thumbnail);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getEventList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateEvent(EventBody eventBody, int id) async {
    isLoading = true;
    update();
    Response? response = await eventRepository.updateEvent(eventBody,Get.find<PickImageController>().thumbnail, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getEventList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteEvent(int id) async {
    isLoading = true;
    Response? response = await eventRepository.deleteEvent(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getEventList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
}