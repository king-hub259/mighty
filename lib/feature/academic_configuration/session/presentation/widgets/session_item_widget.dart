import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/academic_configuration/session/domain/models/session_model.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/screens/create_new_session_screen.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SessionItemWidget extends StatelessWidget {
  final SessionItem? sessionItem;
  final int index;
  final bool changeSession;
  const SessionItemWidget({super.key, this.sessionItem, required this.index,  this.changeSession = false});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(spacing: Dimensions.paddingSizeSmall, children: [
        NumberingWidget(index: index),
        Expanded(child: Text("${sessionItem?.session}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        Expanded(child: Text(sessionItem?.year??'', style: textRegular.copyWith())),

        if(!changeSession)
          EditDeleteSection(horizontal: true, onEdit: (){
            Get.dialog(CreateNewSessionScreen(sessionItem: sessionItem));
          },
            onDelete: (){
              Get.dialog(ConfirmationDialog(title: "session", content: "session",
                onTap: (){
                  Get.back();
                  Get.find<SessionController>().deleteSession(sessionItem!.id!);
                },));

            },)
      ],
      ) :
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
        child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("${"session".tr} : ${sessionItem?.session}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                const SizedBox(height: Dimensions.paddingSizeSmall,),
                Text("${"year".tr} : ${sessionItem?.year??''}", style: textRegular.copyWith(),),
              ]),
            ),
            EditDeleteSection(onEdit: (){
              Get.dialog(CreateNewSessionScreen(sessionItem: sessionItem));
            },
              onDelete: (){
                Get.dialog(ConfirmationDialog(
                  title: "session",
                  content: "session",
                  onTap: (){
                    Get.back();
                    Get.find<SessionController>().deleteSession(sessionItem!.id!);
                  },));

            },)
          ],
        ),
      ),
    );
  }
}