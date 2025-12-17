import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/widgets/create_new_fees_and_waiver_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/widgets/fees_head_list_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_start_up/controller/fees_management_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_start_up/presentation/widgets/fee_waiver_selection_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/presentation/widgets/fees_sub_head_list_widget.dart';
import 'package:mighty_school/feature/fees_management/waiver/presentation/widgets/waiver_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class FeesStartUpWidget extends StatefulWidget {
  const FeesStartUpWidget({super.key});

  @override
  State<FeesStartUpWidget> createState() => _FeesStartUpWidgetState();
}

class _FeesStartUpWidgetState extends State<FeesStartUpWidget> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesManagementController>(
      builder: (feesController) {
        return CustomContainer(
          child: Column(children: [
            const FeeWaiverSelectionWidget(),


            if(feesController.feesStartupTypeIndex == 0)
            FeesHeadListWidget(scrollController: scrollController),

            if(feesController.feesStartupTypeIndex == 1)
              FeesSubHeadListWidget(scrollController: scrollController),

            if(feesController.feesStartupTypeIndex == 2)
              WaiverListWidget(scrollController: scrollController),
          ],),
        );
      }
    );
  }
}
