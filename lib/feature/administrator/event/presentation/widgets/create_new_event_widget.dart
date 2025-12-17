import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_pick_image_widget.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/feature/administrator/event/controller/event_controller.dart';
import 'package:mighty_school/feature/administrator/event/domain/models/event_body.dart';
import 'package:mighty_school/feature/administrator/event/domain/models/event_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewEventWidget extends StatefulWidget {
  final EventItem? eventItem;
  const CreateNewEventWidget({super.key, this.eventItem});

  @override
  State<CreateNewEventWidget> createState() => _CreateNewEventWidgetState();
}

class _CreateNewEventWidgetState extends State<CreateNewEventWidget> {
  TextEditingController eventStartDareController = TextEditingController();
  TextEditingController eventEndDareController = TextEditingController();
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDetailsController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.eventItem != null){
      update = true;
      eventTitleController.text = widget.eventItem?.name??'';
      eventDetailsController.text = widget.eventItem?.details??'';
      eventLocationController.text = widget.eventItem?.location??'';
      eventStartDareController.text = widget.eventItem?.startDate??'';
      eventEndDareController.text = widget.eventItem?.endDate??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: GetBuilder<EventController>(
          builder: (eventController) {
            return Column(mainAxisSize: MainAxisSize.min, children: [

              CustomPickImageWidget(imageUrl: widget.eventItem?.image,),


              Row(children: [
                Expanded(child: DateSelectionWidget( title: "start_date".tr,)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child:  DateSelectionWidget( title: "end_date".tr, end: true,))
              ],
              ),




              CustomTextField(title: "title".tr,
                controller: eventTitleController,
                hintText: "title".tr,),

              CustomTextField(title: "description".tr,
                controller: eventDetailsController,
                hintText: "description".tr,),

              CustomTextField(title: "location".tr,
                controller: eventLocationController,
                hintText: "location".tr,),



              eventController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){

                    String title = eventTitleController.text.trim();
                    String details = eventDetailsController.text.trim();
                    String location = eventLocationController.text.trim();
                    String start = Get.find<DatePickerController>().formatedDate;
                    String end = Get.find<DatePickerController>().formatedEndDate;
                    if(title.isEmpty){
                      showCustomSnackBar("title_is_empty".tr);
                    }
                    else if(details.isEmpty){
                      showCustomSnackBar("details_is_empty".tr);
                    }
                    else if(location.isEmpty){
                      showCustomSnackBar("location_is_empty".tr);
                    }
                    else if(start.isEmpty){
                      showCustomSnackBar("start_date_is_empty".tr);
                    }
                    else if(end.isEmpty){
                      showCustomSnackBar("end_date_is_empty".tr);
                    }
                    else{
                      EventBody eventBody = EventBody(
                        name: title,
                        details: details,
                        location: location,
                        startDate: start,
                        endDate: end,
                        sMethod: update? "put":"post"
                      );
                      if(update){
                        eventController.updateEvent(eventBody, widget.eventItem!.id!);
                      }else{
                        eventController.createNewEvent(eventBody);
                      }

                    }
                  }, text: "confirm".tr))
            ],);
          }
      ),
    );
  }
}
