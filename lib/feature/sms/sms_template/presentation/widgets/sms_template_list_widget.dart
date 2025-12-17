import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/sms/sms_template/controller/sms_template_controller.dart';
import 'package:mighty_school/feature/sms/sms_template/presentation/screens/create_new_sms_template_screen.dart';
import 'package:mighty_school/feature/sms/sms_template/presentation/widgets/sms_template_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SmsTemplateListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const SmsTemplateListWidget({super.key, required this.scrollController});

  @override
  State<SmsTemplateListWidget> createState() => _SmsTemplateListWidgetState();
}

class _SmsTemplateListWidgetState extends State<SmsTemplateListWidget> {
  @override
  void initState() {
    Get.find<SmsTemplateController>().getSmsTemplateList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmsTemplateController>(
        builder: (smsTemplateController) {
          var sms = smsTemplateController.smsTemplateModel?.data;
          return CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent,
            child: Column(children: [
              if(ResponsiveHelper.isDesktop(context))...[
                CustomTitle(title: "sms_template_list", widget: SizedBox(width: 120, child: CustomButton(onTap: (){
                  Get.dialog(const CreateNewSmsTemplateScreen());
                }, text: "add".tr)),),
                Row(spacing: Dimensions.paddingSizeSmall, children: [
                  Expanded(child: Text("name".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  Expanded(child: Text("description",maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  Text("action",maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),

                ],
                ),
              ],


              smsTemplateController.smsTemplateModel != null? (smsTemplateController.smsTemplateModel!.data!= null && smsTemplateController.smsTemplateModel!.data!.isNotEmpty)?
              ListView.builder(
                  itemCount: sms?.length??0,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return SmsTemplateItemWidget(index: index, smsTemplateItem: sms?[index]);
                  }):
              Padding(padding: EdgeInsets.symmetric(vertical: Get.height/2), child: const Center(child: NoDataFound())):
              Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator()),
            ],),
          );
        }
    );
  }
}
