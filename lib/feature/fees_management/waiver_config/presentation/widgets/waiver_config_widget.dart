import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/fees_management/waiver_config/controller/waiver_config_controller.dart';
import 'package:mighty_school/feature/fees_management/waiver_config/presentation/widgets/waiver_assign_and_config_widget.dart';
import 'package:mighty_school/feature/fees_management/waiver_config/presentation/widgets/waiver_assign_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class WaiverConfigWidget extends StatelessWidget {
  const WaiverConfigWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverConfigController>(
        builder: (waiverConfigController) {
          return CustomContainer(
            child: Column(children: [
              const WaiverAssignAndConfigTypeWidget(),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              if(waiverConfigController.waiverConfigTypeIndex == 0)
                const WaiverAssignWidget(),



            ],),
          );
        }
    );
  }
}
