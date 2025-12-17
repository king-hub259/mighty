import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/presentation/widgets/salary_slip_filter_widget.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/presentation/widgets/salary_slip_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class SalarySlipScreen extends StatefulWidget {
  const SalarySlipScreen({super.key});

  @override
  State<SalarySlipScreen> createState() => _SalarySlipScreenState();
}

class _SalarySlipScreenState extends State<SalarySlipScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "salary_slip".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                const SalarySlipFilterWidget(),
                const SizedBox(height: Dimensions.paddingSizeLarge),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
                  child: SalarySlipListWidget(scrollController: scrollController),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}