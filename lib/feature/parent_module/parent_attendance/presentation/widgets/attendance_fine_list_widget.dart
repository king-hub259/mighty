import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/controller/parent_attendance_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/domain/models/attendance_fine_model.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/presentation/widgets/attendance_fine_item_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AttendanceFineListWidget extends  StatelessWidget {
  final ScrollController scrollController;
  const AttendanceFineListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentAttendanceController>(
      initState: (val){
        Get.find<ParentAttendanceController>().getAttendanceFine();
      },
        builder: (attendanceController) {
        AttendanceFineModel? attendanceFineModel = attendanceController.attendanceFineModel;
          var attendanceFine = attendanceFineModel?.data;
          return Column(spacing: Dimensions.paddingSizeDefault, children: [
            attendanceFineModel != null? (attendanceFine!= null && attendanceFine.months!.isNotEmpty)?
            ListView.builder(
                itemCount: attendanceFine.months?.length??0,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return AttendanceFineItemWidget(index: index, fineItem: attendanceFine.months?[index],);
                }):
            Padding(padding: ThemeShadow.getPadding(),
              child: const Center(child: NoDataFound()),
            ):
            Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator()),
          ],);
        }
    );
  }
}
