import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/administrator/event/controller/event_controller.dart';
import 'package:mighty_school/feature/administrator/event/domain/models/event_model.dart';
import 'package:mighty_school/feature/administrator/event/presentation/screens/create_new_event_screen.dart';
import 'package:mighty_school/feature/administrator/event/presentation/widgets/create_new_event_widget.dart';
import 'package:mighty_school/helper/date_converter.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class EventItemWidget extends StatelessWidget {
  final EventItem? eventItem;
  final int index;
  const EventItemWidget({super.key, this.eventItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: Row(spacing: Dimensions.paddingSizeDefault,
        children: [
          NumberingWidget(index: index),
            CustomImage(width: 40, height: 40,image: "${AppConstants.imageBaseUrl}/event/${eventItem?.image}"),
            Expanded(child: CustomItemTextWidget(text: eventItem?.name??'N/A')),
            Expanded(child: CustomItemTextWidget(text: eventItem?.details??'N/A')),
            Expanded(child: CustomItemTextWidget(text: eventItem?.location??'N/A')),
            Expanded(child: CustomItemTextWidget(text: DateConverter.dateTimeStringToDateTime(eventItem?.startDate??''))),
            Expanded(child: CustomItemTextWidget(text: DateConverter.dateTimeStringToDateTime(eventItem?.endDate??''))),

          EditDeleteSection(horizontal: true, onEdit: (){
            Get.dialog(Dialog(child: CreateNewEventWidget(eventItem: eventItem)));
          },
            onDelete: (){
              Get.dialog(ConfirmationDialog(
                title: "notice",
                content: "notice",
                onTap: (){
                  Get.back();
                  Get.find<EventController>().deleteEvent(eventItem!.id!);
                },));

            },)
        ],
      ),
    ):
    Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${"title".tr} : ${eventItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Text("${"description".tr} : ${eventItem?.details??''}", style: textRegular.copyWith(),),
            Text("${"start".tr} : ${DateConverter.dateTimeStringToDateTime(eventItem?.startDate??'')}", style: textRegular.copyWith(),),
            Text("${"end".tr} : ${DateConverter.dateTimeStringToDateTime(eventItem?.endDate??'')}", style: textRegular.copyWith(),),

          ]),
          ),
          EditDeleteSection(onEdit: (){
            Get.to(() => CreateNewEventScreen(eventItem: eventItem));
          },
            onDelete: (){
              Get.dialog(ConfirmationDialog(
                title: "notice",
                content: "notice",
                onTap: (){
                  Get.back();
                  Get.find<EventController>().deleteEvent(eventItem!.id!);
                },));

            },)
        ],
      ),
    );
  }
}