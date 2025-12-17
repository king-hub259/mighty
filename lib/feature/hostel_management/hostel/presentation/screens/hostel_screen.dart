import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/hostel_management/hostel/presentation/screens/add_new_hostel_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel/presentation/widgets/hostel_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelScreen extends StatefulWidget {
  const HostelScreen({super.key});

  @override
  State<HostelScreen> createState() => _HostelScreenState();
}

class _HostelScreenState extends State<HostelScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "hostels".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: HostelListWidget(),
          ),
        )
      ]),
      floatingActionButton: CustomFloatingButton(
        onTap: () => Get.dialog(const AddNewHostelScreen())
      ),
    );
  }
}