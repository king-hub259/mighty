import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class LibraryHistoryItemWidget extends StatelessWidget {
  final BookIssueItem? bookIssueItem;
  final int index;
  const LibraryHistoryItemWidget({super.key, this.bookIssueItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(color: index%2==1? const Color(0xFFDDFDE9): const Color(0xFFFDF6DC)),
        child: Padding(padding: const EdgeInsets.all(8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${bookIssueItem?.bookName}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("${"issued".tr}: ${bookIssueItem?.issueDate??''}", style: textRegular.copyWith()),
            Text("${"due_date".tr}: ${bookIssueItem?.dueDate??''}", style: textRegular.copyWith()),
            Text("${"returned".tr}: ${bookIssueItem?.returnDate??'not_returned_yet'.tr}", style: textRegular.copyWith()),
          ]))),
    );
  }
}