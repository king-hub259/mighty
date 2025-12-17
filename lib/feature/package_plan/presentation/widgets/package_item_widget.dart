import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/package_plan/controller/package_controller.dart';
import 'package:mighty_school/feature/package_plan/domain/models/package_model.dart';
import 'package:mighty_school/feature/package_plan/presentation/screens/create_new_package_screen.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PackageItemWidget extends StatelessWidget {
  final PackageItem? packageItem;
  final int index;
  const PackageItemWidget({super.key, this.packageItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: Column(children: [
          Row(children: [
              Expanded(child: Text("${packageItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
              Expanded(child: Text(packageItem?.description??'', style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
              Expanded(child: Text(PriceConverter.convertPrice(context, packageItem?.price ?? 0), style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
              Expanded(child: Text("${packageItem?.durationDays?.toString()??'0'} ${"days".tr}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
              EditDeleteSection(horizontal: true, onEdit: (){
                Get.dialog(CreateNewPackageScreen(packageItem: packageItem));
              },
                onDelete: (){
                Get.dialog(ConfirmationDialog(
                  title: "subscription_plan",
                    content: "subscription_plan".tr,
                    onTap: (){
                  Get.back();
                  Get.find<PackageController>().deletePackage(packageItem!.id!);
                }));

              },)
            ],),
          const CustomDivider(verticalPadding: Dimensions.paddingSizeExtraSmall,)
        ],
      ),

    );
  }
}