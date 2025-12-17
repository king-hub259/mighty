import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_report_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BookIssueReportResultItemWidget extends StatelessWidget {
  final BookIssueReportResultItem? issueItem;
  final int index;
  const BookIssueReportResultItemWidget({super.key, this.issueItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Text('${issueItem?.code}', style: textRegular.copyWith(),)),
            Expanded(child: Text('${issueItem?.bookName}', maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(),)),
            Expanded(child: Text('${issueItem?.type}', style: textRegular.copyWith(),)),
            Expanded(child: Text('${issueItem?.libraryId}', style: textRegular.copyWith(),)),
            Expanded(child: Text('${issueItem?.studentFirstName} ${issueItem?.studentLastName}', style: textRegular.copyWith(),)),
            Expanded(child: Text('${issueItem?.issueDate}', style: textRegular.copyWith(),)),
            Expanded(child: Text('${issueItem?.status}', style: textRegular.copyWith(),)),


          ]),
          const CustomDivider(verticalPadding: Dimensions.paddingSizeExtraSmall,)
        ],
      ):
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,

        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Text('${issueItem?.bookName}', style: textRegular.copyWith(),),

            ],),
          ),

        ],
        ),
      ),
    );
  }
}
