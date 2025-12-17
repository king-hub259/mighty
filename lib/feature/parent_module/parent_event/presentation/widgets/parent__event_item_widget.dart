import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/administrator/event/domain/models/event_model.dart';
import 'package:mighty_school/helper/date_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ParentEventItemWidget extends StatelessWidget {
  final EventItem? eventItem;
  final int index;
  const ParentEventItemWidget({super.key, this.eventItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(borderRadius: Dimensions.paddingSizeSmall, borderWidth: .5,
          showShadow: false, borderColor: Theme.of(context).hintColor, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${eventItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Text(eventItem?.details??'', style: textRegular.copyWith(),),
            Text("${"date".tr} : ${DateConverter.dateTimeStringToDateTime(eventItem?.startDate??'')} - ${DateConverter.dateTimeStringToDateTime(eventItem?.endDate??'')}", style: textRegular.copyWith(),),

        ])),
    );
  }
}