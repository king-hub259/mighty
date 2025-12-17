import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/screens/create_new_class_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ClassWidget extends StatelessWidget {
  final ClassItem? classItem;
  final int index;
  const ClassWidget({super.key, this.classItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${classItem?.className}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "account", content: "account",
            onTap: (){
              Get.back();
              Get.find<ClassController>().deleteClass(classItem!.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewClassScreen(classItem: classItem));
        },)
      ],
      ),
    );
  }
}
