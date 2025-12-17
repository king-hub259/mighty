import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/domain/model/transport_member_body.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/domain/model/transport_member_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/domain/repository/transport_member_repository.dart';

class TransportMemberController extends GetxController implements GetxService {
  final TransportMemberRepository transportMemberRepository;
  TransportMemberController({required this.transportMemberRepository});

  TransportMemberModel? transportMemberModel;
  Future<void> getTransportMemberList(int page) async {
    Response? response = await transportMemberRepository.getTransportMemberList(page);
    if (response?.statusCode == 200) {
      if (page == 1) {
        transportMemberModel = TransportMemberModel.fromJson(response?.body);
      } else {
        transportMemberModel?.data?.data?.addAll(TransportMemberModel.fromJson(response?.body).data!.data!);
        transportMemberModel?.data?.currentPage = TransportMemberModel.fromJson(response?.body).data?.currentPage;
        transportMemberModel?.data?.total = TransportMemberModel.fromJson(response?.body).data?.total;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  TransportMemberItem? selectedTransportMemberItem;
  void setSelectedTransportMemberItem(TransportMemberItem item) {
    selectedTransportMemberItem = item;
    update();
  }

  bool isLoading = false;
  Future<void> createTransportMember(TransportMemberBody transportMemberBody) async {
    isLoading = true;
    update();
    Response? response = await transportMemberRepository.createTransportMember(transportMemberBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getTransportMemberList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateTransportMember(TransportMemberBody transportMemberBody, int id) async {
    isLoading = true;
    update();
    Response? response = await transportMemberRepository.updateTransportMember(transportMemberBody, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getTransportMemberList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteTransportMember(int id) async {
    Response? response = await transportMemberRepository.deleteTransportMember(id);
    if (response?.statusCode == 200) {
      getTransportMemberList(1);
      showCustomSnackBar("deleted_successfully".tr, isError: false);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  