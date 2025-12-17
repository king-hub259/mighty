import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/administrator/event/domain/models/event_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class EventRepository{
  final ApiClient apiClient;
  EventRepository({required this.apiClient});


  Future<Response?> getEventList(int page) async {
    return await apiClient.getData("${AppConstants.events}?page=$page&perPage=10");
  }

  Future<Response?> createNewEvent( EventBody eventBody, XFile? file) async {
    return await apiClient.postMultipartData(AppConstants.events, eventBody.toJson(),[],MultipartBody("image", file),[]);
  }

  Future<Response?> updateEvent(EventBody eventBody,  XFile? file, int id) async {
    return await apiClient.postMultipartData("${AppConstants.events}/$id", eventBody.toJson(),[],MultipartBody("image", file),[]);
  }
  

  Future<Response?> deleteEvent (int id) async {
    return await apiClient.deleteData("${AppConstants.events}/$id");
  }
}