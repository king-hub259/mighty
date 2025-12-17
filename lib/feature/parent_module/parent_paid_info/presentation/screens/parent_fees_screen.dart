import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_delegate.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_fees_type_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_paid_info_list_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_un_paid_report_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';


class ParentFeesScreen extends StatefulWidget {
  const ParentFeesScreen({super.key});

  @override
  State<ParentFeesScreen> createState() => _ParentFeesScreenState();
}

class _ParentFeesScreenState extends State<ParentFeesScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "fees".tr),
      body: CustomWebScrollView(slivers: [


        SliverPersistentHeader(pinned: true,floating: true, delegate: SliverDelegate(height: 70,
            child: const ParentFeesTypeWidget())),


        SliverToBoxAdapter(child: GetBuilder<ParentPaidInfoController>(
            builder: (paidInfoController) {
              return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: paidInfoController.selectedFeesTypeIndex == 0?
                ParentPaidReportListWidget(scrollController: scrollController):
                ParentUnPaidReportListWidget(scrollController: scrollController),
              );
            }
        ),)
      ],),
    );
  }
}


