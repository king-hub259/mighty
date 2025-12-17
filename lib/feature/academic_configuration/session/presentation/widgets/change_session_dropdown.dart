

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/academic_configuration/session/domain/models/session_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ChangeSessionDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<SessionItem>? items ;
  final Function(SessionItem?)? onChanged;
  final SessionItem? selectedValue;
  const ChangeSessionDropdown({super.key, this.width, this.border = false, required this.title, this.items, this.onChanged, this.selectedValue});

  @override
  State<ChangeSessionDropdown> createState() => _ChangeSessionDropdownState();
}

class _ChangeSessionDropdownState extends State<ChangeSessionDropdown> {


  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      border: Border.all(width: .5, color: Theme.of(context).hintColor), ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<SessionItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(widget.selectedValue?.year?? widget.title.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),),
        items: widget.items != null?
        widget.items?.map((SessionItem item) => DropdownMenuItem<SessionItem>(
            value: item, child: Text(item.year??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))).toList():[],
        value: widget.selectedValue,
        onChanged: widget.onChanged,

        buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero,
            height: 35, width: widget.width?? 100),
        menuItemStyleData: const MenuItemStyleData(height: 35),
      ),
    );
  }
}
