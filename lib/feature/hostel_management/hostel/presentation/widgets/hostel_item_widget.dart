import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/model/hostel_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel/logic/hostel_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel/presentation/screens/add_new_hostel_screen.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelItemWidget extends StatelessWidget {
  final HostelItem hostelItem;
  final int index;
  
  const HostelItemWidget({super.key, required this.hostelItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelController>(builder: (hostelController) {
        return ResponsiveHelper.isDesktop(context) ? _buildDesktopView(context, hostelController) : _buildMobileView(context, hostelController);
      },
    );
  }

  Widget _buildDesktopView(BuildContext context, HostelController hostelController) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: hostelItem.hostelName ?? 'N/A')),
      Expanded(child: CustomItemTextWidget(text: hostelItem.address ?? 'N/A')),
      Expanded(child: CustomItemTextWidget(text: hostelItem.type ?? 'N/A')),
      EditDeleteSection(horizontal: true,
          onEdit: () => Get.dialog( AddNewHostelScreen(hostelItem: hostelItem)),
          onDelete: () => Get.dialog(ConfirmationDialog(
              title: "hostel".tr, content: "hostel".tr,
              onTap: () {
                Get.back();
                hostelController.deleteHostel(hostelItem.id!);
              }))),
      ],
    );
  }

  Widget _buildMobileView(BuildContext context, HostelController hostelController) {
    return CustomContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


        CustomItemTextWidget(text: hostelItem.hostelName ?? 'N/A'),
        CustomItemTextWidget(text: hostelItem.address ?? 'N/A'),
        CustomItemTextWidget(text: hostelItem.type ?? 'N/A'),

        EditDeleteSection(
          onEdit: () => Get.dialog(AddNewHostelScreen(hostelItem: hostelItem)),
          onDelete: () => Get.dialog(ConfirmationDialog(
            title: "hostel".tr, content: "hostel".tr,
              onTap: () {
                Get.back();
                hostelController.deleteHostel(hostelItem.id!);
              }))),
        ],
      ),
    );
  }
}
