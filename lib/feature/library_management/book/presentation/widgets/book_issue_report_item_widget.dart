import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_model.dart';
import 'package:mighty_school/helper/date_converter.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BookIssueReportItemWidget extends StatelessWidget {
  final BookIssueItem? bookIssueItem;
  final int index;
  const BookIssueReportItemWidget({super.key, this.bookIssueItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Column(
      children: [
        Row(children: [
          SizedBox(width: 20, child: Checkbox(value: bookIssueItem?.isSelected??false, onChanged: (val){
            Get.find<BookController>().toggleBookIssues(index);
          }),),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text(bookIssueItem?.code??'', style: textRegular,)),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text(bookIssueItem?.libraryId??'', style: textRegular,)),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text(bookIssueItem?.bookName??'', style: textRegular,)),
          const SizedBox(width: Dimensions.paddingSizeSmall),


          Expanded(child: Text(DateConverter.quotationDate(DateTime.parse(bookIssueItem?.updatedAt??'${DateTime.now()}')), style: textRegular,)),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text(bookIssueItem?.issueDate??'', style: textRegular,)),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: CustomTextField(
            inputType: TextInputType.number,
            inputFormatters: [AppConstants.numberFormat],
              controller: bookIssueItem?.fineController, hintText: "0")),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: CustomTextField(
              inputType: TextInputType.number,
              inputFormatters: [AppConstants.numberFormat],
              controller: bookIssueItem?.lostController, hintText: "0")),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text(bookIssueItem?.status??'', style: textRegular,)),




        ],),
        const CustomDivider(),
      ],
    ):
    Row(children: [
      SizedBox(width: 20, child: Checkbox(value: false, onChanged: (val){}),),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Expanded(child: Text(bookIssueItem?.code??'', style: textRegular,)),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Expanded(child: Text(bookIssueItem?.libraryId??'', style: textRegular,)),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Expanded(child: Text(bookIssueItem?.bookName??'', style: textRegular,)),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Expanded(child: Text(bookIssueItem?.issueDate??'', style: textRegular,)),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Expanded(child: Text(bookIssueItem?.returnDate??'', style: textRegular,)),
      const SizedBox(width: Dimensions.paddingSizeSmall),
      const Expanded(child: CustomTextField()),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      const Expanded(child: CustomTextField()),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      Expanded(child: Text(bookIssueItem?.status??'', style: textRegular,)),
      const SizedBox(width: Dimensions.paddingSizeSmall),

      EditDeleteSection(onEdit: (){},onDelete: (){})



    ],);
  }
}
