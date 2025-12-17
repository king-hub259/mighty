import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/controller/parent_attendance_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/domain/models/attendance_fine_model.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/presentation/screens/attendance_fine_screen.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class AttendanceFineSummeryWidget extends StatelessWidget {
  const AttendanceFineSummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentAttendanceController>(
      initState: (val) {
        if(Get.find<ParentAttendanceController>().attendanceFineModel == null) {
          Get.find<ParentAttendanceController>().getAttendanceFine();
        }
      },
      builder: (attendanceController) {
        AttendanceFineModel? attendanceFineModel = attendanceController.attendanceFineModel;
        return CustomContainer(onTap: ()=> Get.to(()=> const AttendanceFineScreen()),
          showShadow: false, borderRadius : Dimensions.paddingSizeExtraSmall,
          color: Theme.of(context).colorScheme.error.withAlpha(50),
          child: Row(children: [
             Expanded(child: Column(spacing: Dimensions.paddingSizeExtraSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("total_attendance_fine".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.displayMedium?.color) ),
              Text(PriceConverter.convertPrice(context,attendanceFineModel?.data?.totalFineAmount??0 ),
                  style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).colorScheme.error) ),
                ],
              ),
            ),

           IconButton(onPressed: (){
             Get.to(()=> const AttendanceFineScreen());
           }, icon: const CustomImage(width: 30, height: 30, localAsset: true, image: Images.fine,)),
          ]),
        );
      }
    );
  }
}
