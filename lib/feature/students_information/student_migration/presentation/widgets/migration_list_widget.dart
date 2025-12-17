import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/heading_menu_widget.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/section_header_with_path_widget.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/session_selection_widget.dart';
import 'package:mighty_school/feature/students_information/student_migration/controller/student_migration_controller.dart';
import 'package:mighty_school/feature/students_information/student_migration/presentation/widgets/migration_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class MigrationListWidget extends StatelessWidget {
  const MigrationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentMigrationController>(builder: (studentController) {
          var student = studentController.migrationModel?.data;
          return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(children: [
              SectionHeaderWithPath(sectionTitle: "student_information".tr, pathItems: ["migration".tr]),

                CustomContainer(horizontalPadding: ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeDefault : 0, color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor: Theme.of(context).scaffoldBackgroundColor, showShadow: false,
                  child: Column(children: [

                    Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeSmall, children: [
                        const Expanded(child: SelectSessionWidget()),
                      const Expanded(child: SelectClassWidget()),
                        const Expanded(child: SelectSectionWidget()),
                        Padding(padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(width: 90, child: CustomButton(onTap: (){
                              studentController.getMigrationList(Get.find<SessionController>().selectedSessionItem!.id!, Get.find<SectionController>().selectedSectionItem?.id??3);
                            }, text: "search".tr, innerPadding: EdgeInsets.zero)))]),

                      const HeadingMenu(headings: [
                        "image", "roll", "name", "phone", "gender", "section", "class", "new_roll"
                      ]),

                    studentController.migrationModel != null? (studentController.migrationModel!.data!= null && studentController.migrationModel!.data!.isNotEmpty)?
                    ListView.builder(itemCount: student?.length??0,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return MigrationItemWidget(index: index, studentItem: student?[index],);
                        }):
                    Padding(padding: EdgeInsets.symmetric(vertical: Get.height/4), child: const Center(child: NoDataFound())):
                    const SizedBox(),
                  ],),
                ),
              ],
            ),
          );
        }
    );
  }
}
