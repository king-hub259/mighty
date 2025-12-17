import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/domain/model/hostel_category_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/domain/model/hostel_room_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/domain/model/hostel_room_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/domain/repository/hostel_rooms_repository.dart';

class HostelRoomsController extends GetxController implements GetxService {
  final HostelRoomsRepository hostelRoomsRepository;
  HostelRoomsController({required this.hostelRoomsRepository});

  bool isLoading = false;
  ApiResponse<HostelRoomItem>? hostelRoomModel;

  Future<void> getHostelRoomsList({int page = 1}) async {
    Response? response = await hostelRoomsRepository.getHostelRoomsList(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<HostelRoomItem>.fromJson(response!.body, (data) => HostelRoomItem.fromJson(data));

      if(page == 1){
        hostelRoomModel = apiResponse;
      }else {
        hostelRoomModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        hostelRoomModel?.data?.total = apiResponse.data?.total;
        hostelRoomModel?.data?.currentPage = apiResponse.data?.currentPage;
      }

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> addNewHostelRoom(HostelRoomBody roomBody) async {
    isLoading = true;
    update();
    Response? response = await hostelRoomsRepository.addNewHostelRoom(roomBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar('added_successfully'.tr, isError: false);
      getHostelRoomsList();
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> updateHostelRoom(int id, HostelRoomBody roomBody) async {
    isLoading = true;
    update();
    Response? response = await hostelRoomsRepository.updateHostelRoom(id, roomBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar('updated_successfully'.tr, isError: false);
      getHostelRoomsList();
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> deleteHostelRoom(int id) async {
    Response? response = await hostelRoomsRepository.deleteHostelRoom(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar('deleted_successfully'.tr, isError: false);
      getHostelRoomsList();
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }





  List<String> roomTypeList = ["Single", "Double", "Triple", "Dormitory"];
  String selectedRoomType = "Single";

  void setSelectedRoomType(String roomType) {
    selectedRoomType = roomType;
    update();
  }


  List<String> statusList = ["Available", "Occupied", "Maintenance"];
  String selectedStatus = "Available";

  void setSelectedStatus(String status) {
    selectedStatus = status;
    update();
  }
}

