import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/institute/domain/models/institute_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class InstituteItemWidget extends StatelessWidget {
  final InstituteItem? instituteItem;
  final int index;
  const InstituteItemWidget({super.key, this.instituteItem, required this.index,  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
          Row(spacing: Dimensions.paddingSizeSmall, children: [
            SizedBox(width: 50, child: Text("${index+1}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            Expanded(child: Text("${instituteItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            Expanded(child: Text("${instituteItem?.domain}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            Expanded(child: Text("${instituteItem?.phone}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            Expanded(child: Text("${instituteItem?.email}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            Expanded(child: Text(instituteItem?.instituteType?? "N/A", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),

            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: CustomDivider()),
        ],
      ) :
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
        child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("${"institute".tr} : ${instituteItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text("${"domain".tr} : ${instituteItem?.domain}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text("${"phone".tr} : ${instituteItem?.phone}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text("${"email".tr} : ${instituteItem?.email}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text("${"type".tr} : ${instituteItem?.instituteType}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),

              ]),
            ),

          ],
        ),
      ),
    );
  }
}