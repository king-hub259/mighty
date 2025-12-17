import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_to_migration_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_to_migration.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/session_selection_widget.dart';
import 'package:mighty_school/feature/students_information/student_migration/controller/student_migration_controller.dart';
import 'package:mighty_school/feature/students_information/student_migration/domain/models/migration_body.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class MigrationToDialog extends StatelessWidget {
  final bool fromPushBack;
  const MigrationToDialog({super.key, required this.fromPushBack});

  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 500 : Get.width,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: GetBuilder<StudentMigrationController>(
              builder: (migrationController) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: CustomTitle(title: "student_migration")),



                  const Row(children: [
                    Expanded(child: SelectSessionWidget()),
                    SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(child: SelectClassWidgetToMigrationWidget(fromMigration: true,)),
                  ],),

                  const Row(children: [
                    Expanded(child: SelectGroupWidget()),
                    SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(child: SelectSectionToMigrationWidget(fromMigration: true,)),
                  ],),


                  const CustomTitle(title: "type"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomDropdown(width: Get.width, title: "select".tr,
                      items: migrationController.migrationTypes,
                      selectedValue: migrationController.selectedMigrationType,
                      onChanged: (val){
                        migrationController.changeMigrationType(val!);
                      },
                    ),),





                  migrationController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Center(child: CircularProgressIndicator())):

                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: CustomButton(onTap: (){
                        List<int> users = [];
                        List<int> previousRolls  = [];
                        List<int> currentRolls = [];
                        List<int> registrationNumbers = [];
                        for(int i = 0; i < migrationController.studentModelForMigration!.data!.length; i++){
                          if(migrationController.studentModelForMigration!.data![i].isSelected!){
                            users.add(migrationController.studentModelForMigration!.data![i].id!);
                            previousRolls.add(int.parse(migrationController.studentModelForMigration!.data![i].roll!));
                            currentRolls.add(int.parse(migrationController.studentModelForMigration!.data![i].newRollController!.text));
                            registrationNumbers.add(int.parse(migrationController.studentModelForMigration!.data![i].registerNo!));
                          }
                        }


                        int? classId = Get.find<ClassController>().selectedClassItem?.id;
                        int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                        String type = migrationController.selectedMigrationType;
                        int? academicYearId = Get.find<SessionController>().selectedSessionItem?.id;
                        int? groupId = Get.find<GroupController>().groupItem?.id;
                        int? migrateClassId = Get.find<ClassController>().selectedClassItemToMigration?.id;
                        int? migrateSectionId = Get.find<SectionController>().selectedSectionItemForMigration?.id;


                        if(users.isEmpty){
                          showCustomSnackBar("select_student".tr);
                        }
                        else if(classId == null){
                          showCustomSnackBar("select_class".tr);
                        }
                        else if(sectionId == null){
                          showCustomSnackBar("select_section".tr);
                        }
                        else if(classId == migrateClassId){
                          showCustomSnackBar("same_class".tr);
                        }

                        else if(migrationController.studentModelForMigration!.data!.any((element) => element.isSelected == true && element.newRollController!.text.isEmpty)){
                          showCustomSnackBar("enter_new_roll".tr);
                        }
                        else if(academicYearId == null){
                          showCustomSnackBar("select_session".tr);
                        }
                        else if(groupId == null){
                          showCustomSnackBar("select_group".tr);
                        }
                        else if(migrateClassId == null){
                          showCustomSnackBar("select_class".tr);
                        }
                        else if(migrateSectionId == null){
                          showCustomSnackBar("select_section".tr);
                        }
                        else{
                          MigrationBody body = MigrationBody(
                              classId: [classId],
                              sectionId: sectionId,
                              type: type,
                              users: users,
                              prevRoll: previousRolls,
                              registerNo: registrationNumbers,
                              newRoll: currentRolls,
                              academicYear: academicYearId,
                              migrateClassId: migrateClassId,
                              groupId: groupId,
                              migrateSectionId: migrateSectionId);
                          migrationController.studentMigration(body);

                        }
                      }, text:  "confirm".tr))
                ],);
              }
          ),
        ),
      ),
    );
  }
}
