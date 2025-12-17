
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/administrator/event/domain/models/event_model.dart';
import 'package:mighty_school/feature/parent_module/parent_event/domain/repository/parent_event_repository.dart';

class ParentEventController extends GetxController implements GetxService{
  final ParentEventRepository eventRepository;
  ParentEventController({required this.eventRepository});




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

}