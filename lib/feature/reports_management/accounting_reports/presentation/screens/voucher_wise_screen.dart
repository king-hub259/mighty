import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/widgets/voucher_wise_list_widget.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/widgets/from_to_selection_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class VoucherWiseScreen extends StatefulWidget {
  const VoucherWiseScreen({super.key});

  @override
  State<VoucherWiseScreen> createState() => _VoucherWiseScreenState();
}

class _VoucherWiseScreenState extends State<VoucherWiseScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<AccountingReportsController>().voucherWiseModel == null) {
      Get.find<AccountingReportsController>().getVoucherWise();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "voucher_wise_report".tr),
      body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(
            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(spacing: Dimensions.paddingSizeDefault,
                children: [
                  FromToSelectionWidget(onTap: (){
                    Get.find<AccountingReportsController>().getVoucherWise();
                  }),
                  VoucherWiseListWidget(scrollController: scrollController),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
