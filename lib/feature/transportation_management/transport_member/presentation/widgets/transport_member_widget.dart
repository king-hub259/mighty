import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/domain/model/transport_member_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/logic/transport_member_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/presentation/screens/create_new_transport_member_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/presentation/widgets/transport_member_item_widget.dart';

class TransportMemberWidget extends StatelessWidget {
  final ScrollController scrollController;
  const TransportMemberWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransportMemberController>(builder: (transportMemberController) {
      TransportMemberModel? transportMemberModel = transportMemberController.transportMemberModel;
      Data? transportMemberData = transportMemberModel?.data;

      return GenericListSection<TransportMemberItem>(
        sectionTitle: "transportation_management".tr,
        pathItems: ["transport_member".tr],
        addNewTitle: "add_new_transport_member".tr,
        onAddNewTap: () => Get.dialog(const CreateNewTransportMemberDialog()),
        headings: const ["student_name", "class", "route", "stop", "membership_type", "monthly_fee", "status", "action"],
        scrollController: scrollController,
        isLoading: transportMemberModel == null,
        totalSize: transportMemberData?.total ?? 0,
        offset: transportMemberData?.currentPage ?? 0,
        onPaginate: (offset) async => await transportMemberController.getTransportMemberList(offset ?? 1),
        items: transportMemberData?.data ?? [],
        itemBuilder: (item, index) => TransportMemberItemWidget(transportMemberItem: item, index: index),
      );
    });
  }
}