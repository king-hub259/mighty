import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/sms/sms_template/controller/sms_template_controller.dart';
import 'package:mighty_school/feature/sms/sms_template/domain/models/sms_template_model.dart';
import 'package:mighty_school/feature/sms/sms_template/presentation/screens/create_new_sms_template_screen.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SmsTemplateItemWidget extends StatelessWidget {
  final SmsTemplateItem? smsTemplateItem;
  final int index;
  const SmsTemplateItemWidget({super.key, this.smsTemplateItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child:ResponsiveHelper.isDesktop(context)?
      Column(children: [
          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Text("${smsTemplateItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
            Expanded(child: Text("${smsTemplateItem?.description}",maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
            EditDeleteSection(horizontal: true, onEdit: (){
              Get.dialog(CreateNewSmsTemplateScreen(smsTemplateItem: smsTemplateItem));
            },
              onDelete: (){
                Get.find<SmsTemplateController>().deleteSmsTemplate(smsTemplateItem!.id!);
              },)
          ],
          ),
        const CustomDivider(),
        ],
      ):
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Row(children: [
          Expanded(child: Text("${smsTemplateItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
          Expanded(child: Text("${smsTemplateItem?.description}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
          EditDeleteSection(horizontal: true, onEdit: (){
            Get.dialog(CreateNewSmsTemplateScreen(smsTemplateItem: smsTemplateItem));
          },
            onDelete: (){
            Get.find<SmsTemplateController>().deleteSmsTemplate(smsTemplateItem!.id!);
          },)
        ],
      )),
    );
  }
}