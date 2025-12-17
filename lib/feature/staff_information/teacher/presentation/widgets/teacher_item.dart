import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/custom_popup_menu.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/dashboard/controller/dashboard_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/domain/model/teacher_model.dart';
import 'package:mighty_school/feature/staff_information/teacher/presentation/widgets/add_new_teacher_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class TeacherItemWidget extends StatelessWidget {
  final TeacherItem? teacherItem;
  final int index;
  const TeacherItemWidget({super.key, this.teacherItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(spacing: Dimensions.paddingSizeSmall,children: [
        NumberingWidget(index: index),
        ClipRRect(borderRadius: BorderRadius.circular(120),
            child:  CustomImage(width: Dimensions.profileWebImageSize,
                height: Dimensions.profileWebImageSize,
                image: "${AppConstants.baseUrl}/storage/users/${teacherItem?.image}")),

        Expanded(child: CustomItemTextWidget(text:"${teacherItem?.name}")),
        Expanded(child: CustomItemTextWidget(text:teacherItem?.phone??'',)),
        Expanded(child: CustomItemTextWidget(text:teacherItem?.email??'',)),
        Expanded(child: CustomItemTextWidget(text:teacherItem?.designation??'')),

      _buildPopupMenu(context),


      ],):
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeSmall, children: [
            ClipRRect(borderRadius: BorderRadius.circular(120),
                child:  CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig,
                    image: "${AppConstants.baseUrl}/storage/users/${teacherItem?.image}")),

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomItemTextWidget(text:"${teacherItem?.name} : ${teacherItem?.designation??''}"),
              CustomItemTextWidget(text:" ${teacherItem?.phone??''}",),
              CustomItemTextWidget(text:" ${teacherItem?.phone??''}",),

            ]),
            ),
          _buildPopupMenu(context),

          ],
        ),
      ),
    );
  }
  Widget _buildPopupMenu(BuildContext context) {
    return CustomPopupMenu(
      menuItems: Get.find<DashboardController>().getPopupMenuList(editDelete: true),
      onSelected: (option) {
        if (option.title == "edit".tr) {
          Get.dialog(Dialog(
            child: AddNewTeacherWidget(teacherItem: teacherItem, fromStaff: false),
          ));
        } else if (option.title == "delete".tr) {
          Get.dialog(ConfirmationDialog(
            title: "teacher",
            onTap: () {
              Get.back();
              if (teacherItem?.id != null) {
                Get.find<TeacherController>().deleteTeacher(teacherItem!.id!);
              }
            },
          ));
        }
      },
      child: Icon(Icons.more_vert, color: Theme.of(context).hintColor),
    );
  }
}