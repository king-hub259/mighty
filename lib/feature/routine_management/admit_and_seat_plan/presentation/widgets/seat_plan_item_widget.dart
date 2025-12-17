import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/domain/model/admit_card_model.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/presentation/widgets/admit_card_item_widget.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class SeatPlanItemWidget extends StatelessWidget {
  final AdmitCardItem? admitCardItem;
  final int index;
  const SeatPlanItemWidget({super.key, this.admitCardItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
        child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
            CustomContainer(borderColor: Theme.of(context).hintColor, borderRadius: Dimensions.paddingSizeExtraSmall,
                child: Row(children: [
                  const CustomImage(image: Images.logoWithName, localAsset: true,height: 40,),
                  Expanded(child: Center(child: Column(
                    children: [
                      Text(AppConstants.appName.tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                      Text("B.sc in Computer science & Engineering", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall),),
                    ],
                  ))),
                ])),

            Center(child: Padding(padding: const EdgeInsets.all(8.0),
                child: Text("Seat Plan for First Tem Exam", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)))),

            CustomContainer(borderColor: Theme.of(context).hintColor, borderRadius: Dimensions.paddingSizeExtraSmall,
              child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
                  CustomRow(title: "roll".tr, info: admitCardItem?.student?.rollNo??""),
                  CustomRow(title: "name".tr, info: "${admitCardItem?.student?.firstName??""} ${admitCardItem?.student?.lastName??""}"),
                  CustomRow(title: "section".tr, info: "${admitCardItem?.section?.sectionName??""} ${admitCardItem?.student?.lastName??""}"),
                  CustomRow(title: "group".tr, info: "${admitCardItem?.student?.studentGroup?.groupName??""} ${admitCardItem?.student?.lastName??""}"),
                ],
                )),
                const CustomImage(width: 120, height: 120, image: ''),


              ]),
            ),

          ],
          ),
        ),
      ),
    );
  }
}
