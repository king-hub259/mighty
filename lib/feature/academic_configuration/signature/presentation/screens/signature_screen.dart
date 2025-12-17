
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/academic_configuration/signature/presentation/screens/create_new_signature_screen.dart';
import 'package:mighty_school/feature/academic_configuration/signature/presentation/widgets/signature_list_widget.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});
  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "signature".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: SignatureListWidget(scrollController: scrollController))
      ],),

      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.dialog(const CreateNewSignatureScreen()))
    );
  }
}



