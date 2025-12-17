import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/domain/model/transport_member_model.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/logic/transport_member_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/presentation/screens/create_new_transport_member_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class TransportMemberItemWidget extends StatelessWidget {
  final TransportMemberItem transportMemberItem;
  final int index;
  const TransportMemberItemWidget({super.key, required this.transportMemberItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text(transportMemberItem.student?.name ?? "N/A", style: textRegular.copyWith())),
        Expanded(child: Text(transportMemberItem.student?.className ?? "N/A", style: textRegular.copyWith())),
        Expanded(child: Text(transportMemberItem.route?.routeName ?? "N/A", style: textRegular.copyWith())),
        Expanded(child: Text(transportMemberItem.stop?.stopName ?? "N/A", style: textRegular.copyWith())),
        Expanded(child: Text('${transportMemberItem.membershipType}', style: textRegular.copyWith())),
        Expanded(child: Text('\$${transportMemberItem.monthlyFee}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportMemberItem.status}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "transport_member", content: "transport_member",
            onTap: (){
              Get.back();
              Get.find<TransportMemberController>().deleteTransportMember(transportMemberItem.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewTransportMemberDialog(transportMemberItem: transportMemberItem));
        },)
      ],
      ),
    );
  }
}
