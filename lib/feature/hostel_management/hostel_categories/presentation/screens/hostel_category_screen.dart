import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/presentation/screens/add_new_hostel_category_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/presentation/widgets/hostel_category_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelCategoryScreen extends StatefulWidget {
  const HostelCategoryScreen({super.key});

  @override
  State<HostelCategoryScreen> createState() => _HostelCategoryScreenState();
}

class _HostelCategoryScreenState extends State<HostelCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "hostel_categories".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: HostelCategoryListWidget(),
          ),
        )
      ]),
      floatingActionButton: CustomFloatingButton(
        onTap: () => Get.dialog(const AddNewHostelCategoryScreen())
      ),
    );
  }
}
