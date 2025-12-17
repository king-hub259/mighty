import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/presentation/widgets/admit_card_and_seat_plan_widget.dart';

class AdmitAndSeatPlanScreen extends StatefulWidget {
  const AdmitAndSeatPlanScreen({super.key});

  @override
  State<AdmitAndSeatPlanScreen> createState() => _AdmitAndSeatPlanScreenState();
}

class _AdmitAndSeatPlanScreenState extends State<AdmitAndSeatPlanScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "admit_cart_and_seat_plan".tr),
    body: CustomWebScrollView(controller: scrollController, slivers:   const [

      SliverToBoxAdapter(child: AdmitAndSeatPlanWidget())
    ],),
    );
  }
}
