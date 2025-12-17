
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/sms/phone_book_category/presentation/screens/create_new_phone_book_category_screen.dart';
import 'package:mighty_school/feature/sms/phone_book_category/presentation/widgets/phone_book_category_list_widget.dart';

class PhoneBookCategoryScreen extends StatefulWidget {
  const PhoneBookCategoryScreen({super.key});

  @override
  State<PhoneBookCategoryScreen> createState() => _PhoneBookCategoryScreenState();
}

class _PhoneBookCategoryScreenState extends State<PhoneBookCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "phone_book_category".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: PhoneBookCategoryListWidget(scrollController: scrollController))
      ],),


      floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=> Get.dialog(const CreateNewPhoneBookCategoryScreen())));
  }
}



