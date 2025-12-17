import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/students_information/student/domain/model/student_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<StudentItem>? items;
  final Function(StudentItem?)? onChanged;
  final StudentItem? selectedValue;
  
  const StudentDropdown({
    super.key, 
    this.width, 
    this.border = false, 
    required this.title, 
    this.items, 
    this.onChanged, 
    this.selectedValue
  });

  @override
  State<StudentDropdown> createState() => _StudentDropdownState();
}

class _StudentDropdownState extends State<StudentDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
        border: Border.all(width: .5, color: Theme.of(context).hintColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<StudentItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(
          widget.selectedValue != null 
            ? (widget.selectedValue!.name ?? '').trim()
            : widget.title.tr, 
          style: textRegular.copyWith(
            color: Theme.of(context).hintColor, 
            fontSize: Dimensions.fontSizeDefault
          ),
        ),
        items: widget.items != null
          ? widget.items?.map((StudentItem item) => DropdownMenuItem<StudentItem>(
              value: item, 
              child: Text(
                "${item.name ?? ''}".trim(),
                style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)
              )
            )).toList()
          : [],
        value: widget.selectedValue,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: widget.width,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: widget.border ? Border.all(color: Colors.black26) : null,
            color: Colors.transparent,
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_forward_ios_outlined),
          iconSize: 14,
          iconEnabledColor: Colors.grey,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).cardColor,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all<double>(6),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
