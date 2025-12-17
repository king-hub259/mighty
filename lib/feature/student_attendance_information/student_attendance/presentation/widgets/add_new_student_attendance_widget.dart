import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:mighty_school/feature/academic_configuration/period/presentation/widgets/select_period_section.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/widgets/select_subject_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class StudentAttendanceFilterSection extends StatefulWidget {
 
  const StudentAttendanceFilterSection({super.key});

  @override
  State<StudentAttendanceFilterSection> createState() => _StudentAttendanceFilterSectionState();
}

class _StudentAttendanceFilterSectionState extends State<StudentAttendanceFilterSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentAttendanceController>(
        builder: (attendanceController) {

          return Padding(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: CustomContainer(horizontalPadding: ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeDefault : 0, color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor, showShadow: false,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Row(spacing : Dimensions.paddingSizeDefault, children: [
                  Expanded(child: SelectClassWidget()),
                  Expanded(child: SelectSectionWidget()),
                ]),

                const Row(spacing: Dimensions.paddingSizeDefault, children: [
                    Expanded(child: SelectPeriodWidget()),
                    Expanded(child: SelectSubjectWidget()),
                  ]),


                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Expanded(child: DateSelectionWidget()),
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  attendanceController.isLoading? const Center(child: CircularProgressIndicator()):
                  SizedBox(width: 120, height: 48, child: CustomButton(onTap: (){
                    int? classId = Get.find<ClassController>().selectedClassItem?.id;
                    int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                    int? periodId = Get.find<PeriodController>().selectedPeriodItem?.id;
                    attendanceController.getStudentListForAttendance(classId!, sectionId!, periodId!, Get.find<DatePickerController>().formatedDate);
                  }, text: "search".tr),),
                ]),

                const SizedBox(height: Dimensions.paddingSizeSmall),
              ],),
            ),
          );
        }
    );
  }
}
