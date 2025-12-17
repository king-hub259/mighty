import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/widgets/cash_flow_statement_list_widget.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/presentation/widgets/from_to_selection_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CashFlowStatementScreen extends StatefulWidget {
  const CashFlowStatementScreen({super.key});

  @override
  State<CashFlowStatementScreen> createState() => _CashFlowStatementScreenState();
}

class _CashFlowStatementScreenState extends State<CashFlowStatementScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<AccountingReportsController>().cashFlowStatementModel == null) {
      Get.find<AccountingReportsController>().getCashFlowStatement();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "cash_flow_statement".tr),
      body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(
            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(spacing: Dimensions.paddingSizeDefault,
                children: [
                  FromToSelectionWidget(onTap: (){
                    Get.find<AccountingReportsController>().getCashFlowStatement();
                  }),
                  CashFlowStatementListWidget(scrollController: scrollController),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
