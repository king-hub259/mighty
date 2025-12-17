import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/controller/staff_attendance_controller.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/presentation/widgets/staff_list_for_attendance_section.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/models/student_attendance_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewStaffAttendanceWidget extends StatefulWidget {
  final AttendanceItem? attendanceItem;
  const AddNewStaffAttendanceWidget({super.key, this.attendanceItem});

  @override
  State<AddNewStaffAttendanceWidget> createState() => _AddNewStaffAttendanceWidgetState();
}

class _AddNewStaffAttendanceWidgetState extends State<AddNewStaffAttendanceWidget> {
  bool update = false;
  @override
  void initState() {

    if(widget.attendanceItem != null){
      update = true;
      noteController.text = widget.attendanceItem?.notes??'';
      dateController.text = widget.attendanceItem?.date??'';
      checkIn.text = widget.attendanceItem?.checkIn??'';
      checkOut.text = widget.attendanceItem?.checkOut??'';

    }
    super.initState();
  }
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController checkIn = TextEditingController();
  TextEditingController checkOut = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffAttendanceController>(
        builder: (attendanceController) {

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: CustomContainer(horizontalPadding: 0, color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor: Theme.of(context).scaffoldBackgroundColor, showShadow: false,
              child: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeSmall, children: [

                Row(children: [

                  Expanded(child: Column(children: [
                    const CustomTitle(title: "role"),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomDropdown(width: Get.width, title: "select".tr,
                        items: attendanceController.staffTypes,
                        selectedValue: attendanceController.selectedStaffType,
                        onChanged: (val){
                          attendanceController.setSelectedStaffType(val!);
                        },
                      ),),
                  ],)),
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  const Expanded(child: DateSelectionWidget()),

                  const SizedBox(width: Dimensions.paddingSizeDefault),


                  attendanceController.isLoading? const Center(child: CircularProgressIndicator()):
                  Padding(padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(width: 120, height: 42, child: CustomButton(onTap: (){
                      attendanceController.getStaffListForAttendance(attendanceController.selectedStaffType??"Staff");
                    }, text: "search".tr),),
                  ),
                ]),


                const StaffListForAttendanceWidget()

              ],),
            ),
          );
        }
    );
  }
}
