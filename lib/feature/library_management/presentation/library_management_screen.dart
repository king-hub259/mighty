import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/library_management/book/presentation/screens/book_screen.dart';
import 'package:mighty_school/feature/library_management/book_category/presentation/screens/book_category_screen.dart';
import 'package:mighty_school/feature/library_management/library_member/presentation/screens/library_member_screen.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/students_information/student/presentation/screens/student_screen.dart';
import 'package:mighty_school/feature/students_information/student_migration/presentation/screens/student_migration_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';


class LibraryManagementScreen extends StatefulWidget {
  const LibraryManagementScreen({super.key});

  @override
  State<LibraryManagementScreen> createState() => _LibraryManagementScreenState();
}

class _LibraryManagementScreenState extends State<LibraryManagementScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.category, title: 'book_categories', widget:  const BookCategoryScreen()),
    MainMenuModel(icon: Images.book, title: 'books', widget:  const BookScreen()),
    MainMenuModel(icon: Images.staff, title: 'members', widget:  const LibraryMemberScreen()),
    MainMenuModel(icon: Images.book, title: 'book_issue', widget:  const StudentMigrationScreen()),
    MainMenuModel(icon: Images.book, title: 'book_issue_search', widget:  const StudentScreen()),
    MainMenuModel(icon: Images.book, title: 'book_issue_report', widget:  const StudentScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "library_management".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: studentInformationItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(studentInformationItems[index].widget),
                      child: SubMenuItemWidget(icon: studentInformationItems[index].icon, title: studentInformationItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
