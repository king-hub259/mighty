import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/zoom_class/domain/model/zoom_class_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ZoomItemWidget extends StatelessWidget {
  final ZoomItem? zoomItem;
  final int index;
  const ZoomItemWidget({super.key, this.zoomItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
        Row(spacing: Dimensions.paddingSizeSmall, children: [
         Expanded(child: Text("${zoomItem?.topic}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
          Expanded(child: Text(zoomItem?.agenda??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
          Expanded(child: Text(zoomItem?.startTime??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
          Expanded(child: Text(zoomItem?.duration?.toString()??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
          Expanded(child: Linkify(maxLines: 2,overflow: TextOverflow.ellipsis,
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
            onOpen: AppConstants.onOpen,
            text: zoomItem?.joinUrl?.toString()??'',)),
          Expanded(child: Linkify( maxLines: 2,overflow: TextOverflow.ellipsis,
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
              onOpen: AppConstants.onOpen,
              text: zoomItem?.startUrl?.toString()??'')),
          EditDeleteSection(onEdit: (){},onDelete: (){}, horizontal: true),
        ]),
        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: CustomDivider())
      ],
      ) :
      CustomContainer(borderRadius: 6, child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(120),
              child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${zoomItem?.topic}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("${"phone".tr} : ${zoomItem?.agenda??''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),

            Text(zoomItem?.startTime??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
            Text(zoomItem?.duration?.toString()??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
            Linkify(maxLines: 2,overflow: TextOverflow.ellipsis,
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
              onOpen: AppConstants.onOpen,
              text: zoomItem?.joinUrl?.toString()??'',),
            Linkify( maxLines: 2,overflow: TextOverflow.ellipsis,
                style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                onOpen: AppConstants.onOpen,
                text: zoomItem?.startUrl?.toString()??''),

          ]),
          ),
        ],
      )),
    );
  }
}