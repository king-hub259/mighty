import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/controller/fees_mapping_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/presentation/screens/fees_mapping_type_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/presentation/widgets/create_new_fee_mapping_widget_web.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/presentation/widgets/fees_mapping_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class FeesMappingWebWidget extends StatefulWidget {
  const FeesMappingWebWidget({super.key});

  @override
  State<FeesMappingWebWidget> createState() => _FeesMappingWebWidgetState();
}

class _FeesMappingWebWidgetState extends State<FeesMappingWebWidget> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesMappingController>(
        builder: (feesMappingController) {
          return CustomContainer(
            child: Column(children: [
              const FeesMappingTypeWidget(),


              if(feesMappingController.feesStartupTypeIndex == 0)
                FeesMappingListWidget(scrollController: scrollController),

              if(feesMappingController.feesStartupTypeIndex == 1)
                FeesMappingListWidget(scrollController: scrollController),

            ],),
          );
        }
    );
  }
}
