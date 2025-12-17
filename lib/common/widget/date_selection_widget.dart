import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/helper/date_converter.dart';
import 'package:mighty_school/util/styles.dart';

class DateSelectionWidget extends StatelessWidget {
  final String? title;
  final bool end;
  const DateSelectionWidget({super.key, this.title,  this.end = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatePickerController>(
        builder: (datePickerController) {
          return InkWell(onTap: ()=> datePickerController.setSelectDate(context, end: end),
              child: CustomTextField(title: title?? "date".tr, isEnabled : false,
                 hintStyle: textRegular.copyWith(color: Theme.of(context).textTheme.displayLarge?.color),
                  hintText: end? DateConverter.quotationDate(datePickerController.selectedEndDate) : DateConverter.quotationDate(datePickerController.selectedDate)));
        }
    );
  }
}
