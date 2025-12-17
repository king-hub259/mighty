import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class AbsentFineWidget extends StatefulWidget {
  const AbsentFineWidget({super.key});

  @override
  State<AbsentFineWidget> createState() => _AbsentFineWidgetState();
}

class _AbsentFineWidgetState extends State<AbsentFineWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentAttendanceController>(builder: (attendanceController) {

          return CustomContainer(marginHorizontal: ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeDefault : 0,
            child: Column(mainAxisSize: MainAxisSize.min, children: [

               const Row(spacing: Dimensions.paddingSizeDefault, children: [
                Expanded(child: SelectClassWidget()),
                Expanded(child: SelectSectionWidget())]),

              Row(spacing: Dimensions.paddingSizeDefault, children: [
                 Expanded(child: DateSelectionWidget(title: "from_date".tr)),
                 Expanded(child: DateSelectionWidget(end: true, title: "to_date".tr)),

                attendanceController.isLoading? const Center(child: CircularProgressIndicator()):
                Padding(padding: const EdgeInsets.only(top: 35.0),
                  child: SizedBox(width: 120, height: 40, child: CustomButton(onTap: (){
                    int? classId = Get.find<ClassController>().selectedClassItem?.id;
                    int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                    int? periodId = Get.find<PeriodController>().selectedPeriodItem?.id;
                    attendanceController.getStudentListForAttendance(classId!, sectionId!, periodId!, Get.find<DatePickerController>().formatedDate);
                  }, text: "search".tr))),
              ]),

              const SizedBox(height: Dimensions.paddingSizeSmall),
            ],),
          );
        }
    );
  }
}
