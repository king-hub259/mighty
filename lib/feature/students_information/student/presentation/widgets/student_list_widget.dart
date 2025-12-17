import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/heading_menu_widget.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/student_item.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentListWidget extends StatelessWidget {
  const StudentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<StudentController>(
        builder: (studentController) {
          var student = studentController.studentModel?.data;
          return Column(children: [
            if(ResponsiveHelper.isDesktop(context))...[
              const HeadingMenu(headings: ["image", "roll",  "name", "phone", "gender", "guardian", "status", "result_card"]),
            ],
            studentController.studentModel != null? (studentController.studentModel!.data!= null && studentController.studentModel!.data!.isNotEmpty)?
            ListView.separated(
                itemCount: student?.length??0,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return StudentItemWidget(index: index, studentItem: student?[index],);
                }, separatorBuilder: (BuildContext context, int index) {
                  return ResponsiveHelper.isDesktop(context)? const CustomDivider() : const SizedBox(height: Dimensions.paddingSizeSmall);
            },):
            Padding(padding: ThemeShadow.getPadding(), child: const Center(child: NoDataFound())):
            const SizedBox(),
          ],);
        }
    );
  }
}
