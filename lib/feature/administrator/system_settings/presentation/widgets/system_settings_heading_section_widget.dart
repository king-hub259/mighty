import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/presentation/widgets/heading_type_button_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class SystemSettingsHeadingSectionWidget extends StatelessWidget {
  const SystemSettingsHeadingSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
      builder: (systemSettingsController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          child: SizedBox(height: 35,
            child: ListView(scrollDirection: Axis.horizontal, shrinkWrap: true,
                padding: EdgeInsets.zero, children: [
                HeadingTypeButtonWidget(title: "general_settings".tr, selected: systemSettingsController.settingsTypeIndex == 0,
                    onTap: () => systemSettingsController.setSelectedSettingsTypeIndex(0)),
                  HeadingTypeButtonWidget(title: "logo".tr, selected: systemSettingsController.settingsTypeIndex == 1,
                      onTap: () => systemSettingsController.setSelectedSettingsTypeIndex(1)),
                  HeadingTypeButtonWidget(title: "theme_color".tr, selected: systemSettingsController.settingsTypeIndex == 2,
                      onTap: () => systemSettingsController.setSelectedSettingsTypeIndex(2)),
                ]),
          ),
        );
      }
    );
  }
}
