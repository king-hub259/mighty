
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/sms/phone_book/presentation/screens/create_new_phone_book_screen.dart';
import 'package:mighty_school/feature/sms/phone_book/presentation/widgets/phone_book_list_widget.dart';

class PhoneBookScreen extends StatefulWidget {
  const PhoneBookScreen({super.key});

  @override
  State<PhoneBookScreen> createState() => _PhoneBookScreenState();
}

class _PhoneBookScreenState extends State<PhoneBookScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "phone_book".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: PhoneBookListWidget(scrollController: scrollController))
      ],),


      floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=> Get.dialog(const CreateNewPhoneBookScreen())));
  }
}



