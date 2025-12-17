import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/controller/fees_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/presentation/screens/fees_type_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/presentation/widgets/fees_list_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/controller/fees_mapping_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/presentation/widgets/fees_mapping_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class FeesWebWidget extends StatefulWidget {
  const FeesWebWidget({super.key});

  @override
  State<FeesWebWidget> createState() => _FeesWebWidgetState();
}

class _FeesWebWidgetState extends State<FeesWebWidget> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesController>(
        builder: (feesController) {
          return CustomContainer(
            child: Column(children: [
              const FeesTypeWidget(),

              if(feesController.feesTypeIndex == 0)
                FeesListWidget(scrollController: scrollController),

              if(feesController.feesTypeIndex == 1)
                FeesMappingListWidget(scrollController: scrollController),

            ],),
          );
        }
    );
  }
}
