import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/hostel_management/hostel_room_member/domain/model/hostel_room_member_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_room_member/domain/repository/hostel_room_member_repository.dart';

class HostelRoomMemberController extends GetxController implements GetxService {
  final HostelRoomMemberRepository hostelRoomMemberRepository;
  HostelRoomMemberController({required this.hostelRoomMemberRepository});



  Future<void> getHostelRoomMember() async {
    Response? response = await hostelRoomMemberRepository.getHostelRoomMembersList(1);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> createHostelRoomMember(HostelRoomMemberBody roomMemberBody) async {
    Response? response = await hostelRoomMemberRepository.addNewHostelRoomMember(roomMemberBody);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editHostelRoomMember(int id, HostelRoomMemberBody roomMemberBody) async {
    Response? response = await hostelRoomMemberRepository.updateHostelRoomMember(id, roomMemberBody);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteHostelRoomMember(int id) async {
    Response? response = await hostelRoomMemberRepository.deleteHostelRoomMember(id);
    if (response?.statusCode == 200) {
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  