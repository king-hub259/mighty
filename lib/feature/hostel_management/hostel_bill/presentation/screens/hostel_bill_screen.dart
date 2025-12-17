import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/presentation/screens/add_new_hostel_bill_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/presentation/widgets/hostel_bill_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelBillScreen extends StatefulWidget {
  const HostelBillScreen({super.key});

  @override
  State<HostelBillScreen> createState() => _HostelBillScreenState();
}

class _HostelBillScreenState extends State<HostelBillScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "hostel_bills".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: HostelBillListWidget())
      ]),
      floatingActionButton: CustomFloatingButton(onTap: () => Get.to(() => const AddNewHostelBillScreen())
      ),
    );
  }
}