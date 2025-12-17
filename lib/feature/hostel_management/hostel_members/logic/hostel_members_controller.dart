import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/domain/model/hostel_member_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/domain/model/hostel_member_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/domain/repository/hostel_members_repository.dart';

class HostelMembersController extends GetxController implements GetxService {
  final HostelMembersRepository hostelMembersRepository;
  HostelMembersController({required this.hostelMembersRepository});

  bool isLoading = false;
  ApiResponse<HostelMemberItem>? hostelMemberModel;
  Future<void> getHostelMembersList({int page = 1}) async {
    Response? response = await hostelMembersRepository.getHostelMembersList(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<HostelMemberItem>.fromJson(response?.body, (data) => HostelMemberItem.fromJson(data));
      if(page == 1) {
        hostelMemberModel = apiResponse;
      }else{
        hostelMemberModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        hostelMemberModel?.data?.total = apiResponse.data?.total;
        hostelMemberModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> addNewHostelMember(HostelMemberBody memberBody) async {
    isLoading = true;
    update();
    Response? response = await hostelMembersRepository.addNewHostelMember(memberBody);
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      isLoading = false;
      Get.back();
      showCustomSnackBar('hostel_member_added_successfully'.tr, isError: false);
      getHostelMembersList();
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> updateHostelMember(int id, HostelMemberBody memberBody) async {
    isLoading = true;
    update();
    Response? response = await hostelMembersRepository.updateHostelMember(id, memberBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar('hostel_member_updated_successfully'.tr, isError: false);
      getHostelMembersList();
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> deleteHostelMember(int id) async {
    Response? response = await hostelMembersRepository.deleteHostelMember(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar('hostel_member_deleted_successfully'.tr, isError: false);
      getHostelMembersList();
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


}
  