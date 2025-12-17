import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/students_information/student_migration/controller/student_migration_controller.dart';
import 'package:mighty_school/feature/students_information/student_migration/presentation/widgets/migration_to_dialog.dart';
import 'package:mighty_school/feature/students_information/student_migration/presentation/widgets/student_item_for_migration_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentListForMigrationWidget extends StatelessWidget {
  final bool fromPushBack;
  const StudentListForMigrationWidget({super.key, this.fromPushBack = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentMigrationController>(
        builder: (studentController) {
          var student = studentController.studentModelForMigration?.data;
          return Column(children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomRoutePathWidget(title: "migration".tr,)),

              CustomContainer(horizontalPadding: Dimensions.paddingSizeDefault, color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor: Theme.of(context).scaffoldBackgroundColor,
                showShadow: false,
                child: Column(children: [


                  if(!ResponsiveHelper.isDesktop(context))
                  Row(crossAxisAlignment: CrossAxisAlignment.end,spacing: Dimensions.paddingSizeSmall, children: [
                    const Expanded(child: SelectClassWidget()),
                    const Expanded(child: SelectSectionWidget()),
                    Padding(padding: const EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(width: 90, child: CustomButton(onTap: (){
                          studentController.getStudentListForMigration(Get.find<ClassController>().selectedClassItem!.id!, Get.find<SectionController>().selectedSectionItem!.id!);
                        }, text: "search".tr, innerPadding: EdgeInsets.zero)))]),


                  if(ResponsiveHelper.isDesktop(context))...[

                    Row(crossAxisAlignment: CrossAxisAlignment.end,spacing: Dimensions.paddingSizeSmall, children: [
                        const Expanded(child: SelectClassWidget()),
                        const Expanded(child: SelectSectionWidget()),
                        Padding(padding: const EdgeInsets.only(bottom: 8.0),
                          child: SizedBox(width: 90, child: CustomButton(onTap: (){
                            studentController.getStudentListForMigration(Get.find<ClassController>().selectedClassItem!.id!, Get.find<SectionController>().selectedSectionItem!.id!);
                          }, text: "search".tr, innerPadding: EdgeInsets.zero)))]),



                      Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width : 20, height: 20,
                                child: Checkbox(value: studentController.allSelected, onChanged: (val){
                                  studentController.selectAll();
                                }),
                              ),
                              const SizedBox(width: Dimensions.paddingSizeDefault),
                              SizedBox(width: 50, child: Text('roll'.tr, style: textMedium.copyWith(),)),
                              const SizedBox(width: Dimensions.paddingSizeSmall),
                              Text('photo'.tr, style: textMedium.copyWith(),),
                              const SizedBox(width: Dimensions.paddingSizeSmall),

                              Expanded(child: Text("name".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                              const SizedBox(width: Dimensions.paddingSizeSmall),

                              Expanded(child: Text("phone".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                              const SizedBox(width: Dimensions.paddingSizeSmall),


                              SizedBox(width: 70, child: Text('gender'.tr, style: textMedium.copyWith(),)),
                              const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                              Expanded(child: Text('new_roll'.tr, style: textMedium.copyWith(),)),

                            ])),

                      const Divider(),

                  ],

                  studentController.studentModelForMigration != null? (studentController.studentModelForMigration!.data!= null && studentController.studentModelForMigration!.data!.isNotEmpty)?
                  Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(itemCount: student?.length??0,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return StudentItemForMigration(index: index, studentItem: student?[index],);
                          }),
                      Align(alignment: Alignment.centerRight,
                        child: SizedBox(width: 90,
                          child: CustomButton(onTap: (){
                            Get.dialog( MigrationToDialog(fromPushBack: fromPushBack));
                          }, text: "proceed".tr),
                        ),
                      )
                    ],
                  ):
                  Padding(padding: EdgeInsets.only(top: Get.height/3), child: const Center(child: NoDataFound())):
                  const SizedBox(),
                ],),
              ),
            ],
          );
        }
    );
  }
}
