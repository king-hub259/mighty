import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/active_inactive_widget.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/hrm/leave_request/controller/leave_request_controller.dart';
import 'package:mighty_school/feature/hrm/leave_request/domain/models/leave_model.dart';
import 'package:mighty_school/feature/hrm/leave_request/presentation/screens/create_new_leave_request_screen.dart';
import 'package:mighty_school/helper/date_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class LeaveRequestItemWidget extends StatelessWidget {
  final LeaveItem? leaveItem;
  final int index;
  const LeaveRequestItemWidget({super.key, this.leaveItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${leaveItem?.employee?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              if(leaveItem?.leaveType != null)
              Text(leaveItem?.leaveType?.name??'', style: textRegular.copyWith(),),
              Text("${"duration".tr} : ${leaveItem?.startDate??''} - ${leaveItem?.endDate??''}", style: textRegular.copyWith(),),
              Text("${"date".tr} : ${DateConverter.quotationDate(DateTime.parse(leaveItem?.createdAt??''))} ", style: textRegular.copyWith(),),
            AttendanceStatusWidget(active: leaveItem?.approvalStatus == 'approved', status: leaveItem?.approvalStatus??'',),

            ]),
          ),
          EditDeleteSection(onEdit: (){
            Get.to(()=> CreateNewLeaveRequestScreen(leaveItem: leaveItem));
          },
            onDelete: (){
            Get.find<LeaveRequestController>().deleteLeaveRequest(leaveItem!.id!);
          },)
        ],
      )),
    );
  }
}