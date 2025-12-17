import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

/// Generic Dropdown
class CustomGenericDropdown<T> extends StatelessWidget {
  final double? width;
  final bool border;
  final String title;
  final List<T>? items;
  final T? selectedValue;
  final Function(T?)? onChanged;
  final String Function(T item) getLabel; // <-- Pass function to extract label

  const CustomGenericDropdown({
    super.key,
    this.width,
    this.border = false,
    required this.title,
    required this.getLabel,
    this.items,
    this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
        border: Border.all(width: .5, color: Theme.of(context).hintColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<T>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(
          selectedValue != null ? getLabel(selectedValue as T) : title.tr,
          style: textRegular.copyWith(
            color: Theme.of(context).textTheme.displayMedium?.color,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
        items: items != null
            ? items!
            .map(
              (T item) => DropdownMenuItem<T>(
            value: item,
            child: Text(
              getLabel(item),
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
            ),
          ),
        )
            .toList()
            : [],
        value: (items != null && selectedValue != null && items!.contains(selectedValue))
            ? selectedValue
            : null,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: width,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: border ? Border.all(color: Colors.black26) : null,
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
          width: width,
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
