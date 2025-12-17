import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/library_management/book_category/presentation/screens/create_new_book_category_dialog.dart';
import 'package:mighty_school/feature/library_management/book_category/presentation/widgets/book_categories_list_widget.dart';

class BookCategoryScreen extends StatefulWidget {
  const BookCategoryScreen({super.key});

  @override
  State<BookCategoryScreen> createState() => _BookCategoryScreenState();
}

class _BookCategoryScreenState extends State<BookCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:  CustomAppBar(title: "book_category".tr),
    body: CustomWebScrollView(controller: scrollController, slivers: [

      SliverToBoxAdapter(child: BookCategoriesListWidget(scrollController: scrollController))
    ],),
      floatingActionButton:  CustomFloatingButton(onTap: ()=> Get.dialog(const CreateNewBookCategoryScreen())));
  }
}
