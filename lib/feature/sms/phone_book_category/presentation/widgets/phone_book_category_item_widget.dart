import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/sms/phone_book_category/controller/phone_book_category_controller.dart';
import 'package:mighty_school/feature/sms/phone_book_category/domain/models/phone_book_category_model.dart';
import 'package:mighty_school/feature/sms/phone_book_category/presentation/screens/create_new_phone_book_category_screen.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PhoneBookCategoryItemWidget extends StatelessWidget {
  final PhoneBookCategoryItem? phoneBookCategoryItem;
  final int index;
  const PhoneBookCategoryItemWidget({super.key, this.phoneBookCategoryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Text("${phoneBookCategoryItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
            EditDeleteSection(horizontal: true, onEdit: (){
              Get.dialog(CreateNewPhoneBookCategoryScreen(phoneBookCategoryItem: phoneBookCategoryItem));
            },
              onDelete: (){
                Get.find<PhoneBookCategoryController>().deletePhoneBookCategory(phoneBookCategoryItem!.id!);
              },)
          ],),
        const CustomDivider()
        ],
      ):
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Row(children: [
          Expanded(child: Text("${phoneBookCategoryItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
          EditDeleteSection(horizontal: true, onEdit: (){
            Get.dialog(CreateNewPhoneBookCategoryScreen(phoneBookCategoryItem: phoneBookCategoryItem));
          },
            onDelete: (){
            Get.find<PhoneBookCategoryController>().deletePhoneBookCategory(phoneBookCategoryItem!.id!);
          },)
        ],
      )),
    );
  }
}