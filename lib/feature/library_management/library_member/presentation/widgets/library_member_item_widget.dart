import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/library_management/library_member/domain/model/library_member_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class LibraryMemberItemWidget extends StatelessWidget {
  final LibraryMemberItem? memberItem;
  final int index;
  const LibraryMemberItemWidget({super.key, this.memberItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      CustomImage(radius: 123, image: "${AppConstants.baseUrl}/storage/users/${memberItem?.user?.image}", width: 25, height: 25),
      Expanded(child: CustomItemTextWidget(text:'${memberItem?.user?.id}')),
      Expanded(child: CustomItemTextWidget(text: '${memberItem?.user?.name}')),
      CustomItemTextWidget(text: '${memberItem?.memberType}'),

    ],
    ):
    CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,

      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomImage(radius: 123, image: "${AppConstants.baseUrl}/storage/users/${memberItem?.user?.image}", width: 25, height: 25),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            CustomItemTextWidget(text:'${memberItem?.user?.id}'),
            CustomItemTextWidget(text: '${memberItem?.user?.name}'),
            CustomItemTextWidget(text: '${memberItem?.memberType}'),

          ],),
        ),

      ],
      ),
    );
  }
}
