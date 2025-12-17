import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/student_header_route_section_section.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/student_list_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class StudentInfoListWidget extends StatelessWidget {
  const StudentInfoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        const StudentHeaderRouteSectionSection(),
        CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor :  Colors.transparent, showShadow: false,
          horizontalPadding: ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeSmall : 0,
          child: Column(children: [


            if(ResponsiveHelper.isDesktop(context))...[
              Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeDefault,
                children: [
                  const Expanded(child: SelectClassWidget()),
                  const Expanded(child: SelectGroupWidget()),
                  const Expanded(child: SelectSectionWidget()),

                  Padding(padding: const EdgeInsets.only(bottom: 8.0),
                    child: GetBuilder<StudentController>(
                        builder: (studentController) {
                          return SizedBox(width: 100, child: studentController.isLoading? const Center(child: CircularProgressIndicator(),) :
                          CustomButton(onTap: (){
                            studentController.getStudentList(Get.find<ClassController>().selectedClassItem!.id!, Get.find<GroupController>().groupItem!.id!, Get.find<SectionController>().selectedSectionItem?.id, "", 1);
                          }, text: "search", innerPadding: EdgeInsets.zero,));
                        }
                    ),
                  )
                ],
              ),
            ]else...[
              const Row(children: [
                  Expanded(child: SelectClassWidget()),
                  SizedBox(width: Dimensions.paddingSizeDefault,),
                  Expanded(child: SelectGroupWidget())]),

              Row(crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(child: SelectSectionWidget()),
                  const SizedBox(width: Dimensions.paddingSizeDefault,),
                  Padding(padding: const EdgeInsets.only(bottom: 8.0),
                    child: GetBuilder<StudentController>(builder: (studentController) {
                          return SizedBox(width: 90, child: CustomButton(onTap: (){
                            studentController.getStudentList(Get.find<ClassController>().selectedClassItem!.id!, Get.find<GroupController>().groupItem!.id!, Get.find<SectionController>().selectedSectionItem!.id!, "", 1);
                          }, text: "search", innerPadding: EdgeInsets.zero,));
                        }))
                ],
              ),
            ],
            const SizedBox(height: Dimensions.paddingSizeDefault),
            const StudentListWidget(),



          ]),
        ),
      ],
    );
  }
}
