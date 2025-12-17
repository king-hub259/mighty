import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class SelectedBookItemWidget extends StatelessWidget {
  final BookItem? bookItem;
  final int index;
  const SelectedBookItemWidget({super.key, this.bookItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Column(children: [
        Row(children: [
          Expanded(child: Text(bookItem?.bookName??'',maxLines: 2, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text(bookItem?.code??'', style: textRegular.copyWith())),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text(bookItem?.author??'', style: textRegular.copyWith())),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text(bookItem?.quantity?.toString()??'', style: textRegular.copyWith())),
          const SizedBox(width: Dimensions.paddingSizeSmall),

           Expanded(child: Container(height: 30, decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(2),
               border: Border.all(width: .2, color: Theme.of(context).hintColor)),
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Row(children: [
                     Expanded(child: Text(bookItem?.returnDate??'', style: textRegular.copyWith())),
                     Icon(Icons.calendar_month, size: 15,color: Theme.of(context).hintColor)
                   ]),
               ))),
          const SizedBox(width: Dimensions.paddingSizeDefault),

          InkWell(onTap: ()=> Get.find<BookController>().removeBook(index),
              child: SizedBox(width : 20, child: Image.asset(Images.deleteIcon)))

        ]),
        const CustomDivider(verticalPadding: Dimensions.paddingSizeSmall)
      ],
    ): Row(children: [
      Expanded(child: Text(bookItem?.bookName??'', style: textRegular.copyWith())),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Expanded(child: Text(bookItem?.bookName??'', style: textRegular.copyWith())),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Expanded(child: Text(bookItem?.bookName??'', style: textRegular.copyWith())),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Expanded(child: Text(bookItem?.bookName??'', style: textRegular.copyWith())),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      const Expanded(child: CustomTextField(hintText: "20-10-2025")),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      SizedBox(width : 20, child: Image.asset(Images.deleteIcon))

    ]);
  }
}
