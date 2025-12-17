import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/domain/model/hostel_bill_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/presentation/screens/add_new_hostel_meal_screen.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/presentation/screens/add_new_hostel_member_screen.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';

class HostelBillItemWidget extends StatelessWidget {
  final HostelBillItem billItem;
  final int index;

  const HostelBillItemWidget({super.key, required this.billItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealsController>(builder: (mealController) {
      return  _buildDesktopView(context, mealController);
    },
    );
  }

  Widget _buildDesktopView(BuildContext context, HostelMealsController mealController) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: billItem.student?.firstName ?? '')),
      Expanded(child: CustomItemTextWidget(text: PriceConverter.convertPrice(context, billItem.hostelFee ?? 0))),
      Expanded(child: CustomItemTextWidget(text: PriceConverter.convertPrice(context, billItem.mealFee ?? 0))),
      CustomItemTextWidget(text: PriceConverter.convertPrice(context, billItem.totalAmount ?? 0)),


    ],
    );
  }

}
