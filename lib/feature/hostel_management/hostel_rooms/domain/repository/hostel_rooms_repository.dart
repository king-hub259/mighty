import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/domain/model/hostel_room_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class HostelRoomsRepository {
  final ApiClient apiClient;

  HostelRoomsRepository({required this.apiClient});

  Future<Response?> getHostelRoomsList(int page) async {
    return await apiClient.getData("${AppConstants.hostelRooms}?per_page=20&page=$page");
  }

  Future<Response?> addNewHostelRoom(HostelRoomBody roomBody) async {
    return await apiClient.postData(AppConstants.hostelRooms, roomBody.toJson());
  }

  Future<Response?> updateHostelRoom(int id, HostelRoomBody roomBody) async {
    return await apiClient.putData("${AppConstants.hostelRooms}/$id", roomBody.toJson());
  }

  Future<Response?> deleteHostelRoom(int id) async {
    return await apiClient.deleteData("${AppConstants.hostelRooms}/$id");
  }

  Future<Response?> getHostelRoomDetails(int id) async {
    return await apiClient.getData("${AppConstants.hostelRooms}/$id");
  }
}
  