
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/sms/sms_template/presentation/screens/create_new_sms_template_screen.dart';
import 'package:mighty_school/feature/sms/sms_template/presentation/widgets/sms_template_list_widget.dart';

class SmsTemplateScreen extends StatefulWidget {
  const SmsTemplateScreen({super.key});

  @override
  State<SmsTemplateScreen> createState() => _SmsTemplateScreenState();
}

class _SmsTemplateScreenState extends State<SmsTemplateScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "sms_template".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: SmsTemplateListWidget(scrollController: scrollController))
      ],),


      floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=> Get.dialog(const CreateNewSmsTemplateScreen())));
  }
}



