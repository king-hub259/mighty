import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/models/student_attendance_body.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/models/student_for_attendance_model.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/widgets/student_attendance_item.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentListForAttendanceWidget extends StatefulWidget {
  const StudentListForAttendanceWidget({super.key});

  @override
  State<StudentListForAttendanceWidget> createState() => _StudentListForAttendanceWidgetState();
}

class _StudentListForAttendanceWidgetState extends State<StudentListForAttendanceWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentAttendanceController>(
        builder: (attendanceController) {
          StudentForAttendanceModel? studentForAttendanceModel = attendanceController.studentForAttendanceModel;
          return studentForAttendanceModel != null? Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(children: [
              Row(children: [
                InkWell(onTap: () => attendanceController.setAllPresent(0),
                  child: Row(children: [
                    Icon(attendanceController.allPresent == 0? Icons.radio_button_checked_rounded : Icons.radio_button_off,
                      color: attendanceController.allPresent == 0? Theme.of(context).primaryColor : Theme.of(context).hintColor,),

                    const SizedBox(width: 5),
                    Text("present".tr, style: textRegular.copyWith())])),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(onTap: ()=>attendanceController.setAllPresent(1),
                    child: Row(children: [
                      Icon(attendanceController.allPresent == 1? Icons.radio_button_checked_rounded : Icons.radio_button_off,
                        color: attendanceController.allPresent == 1? Theme.of(context).primaryColor : Theme.of(context).hintColor,),
                      const SizedBox(width: 5),
                      Text("absent".tr, style: textRegular.copyWith())]),
                  )),
              ]),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: studentForAttendanceModel.data?.length??0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return StudentAttendanceItem(index: index,studentItem: studentForAttendanceModel.data?[index]);
                  }),


              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
                  child: attendanceController.isLoading? const Center(child: CircularProgressIndicator()):
                  CustomButton(onTap: (){
                    List<int>? userIds = [];
                    List<int>? attendance = [];
                    int? classId = Get.find<ClassController>().selectedClassItem?.id;
                    int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                    int? periodId = Get.find<PeriodController>().selectedPeriodItem?.id;
                    int? subjectId = Get.find<SubjectController>().selectedSubjectItem?.id;
                    String date = Get.find<DatePickerController>().formatedDate;
                    for(int i = 0; i<studentForAttendanceModel.data!.length; i++){
                      userIds.add(int.parse(studentForAttendanceModel.data![i].userId!));
                      attendance.add(studentForAttendanceModel.data![i].isPresent!? 1 : 2);
                    }
                    StudentAttendanceBody attendanceBody = StudentAttendanceBody(date: date,
                        studentIds: userIds, attendance: attendance,
                    smsStatus: 0,
                    classId: classId, sectionId: sectionId, periodId: periodId, subjectId: subjectId);
                    attendanceController.createStudentNewAttendance(attendanceBody);


                  }, text: "submit".tr))
            ],
            ),
          ): const SizedBox();
        }
    );
  }
}
