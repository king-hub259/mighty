

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SectionDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<SectionItem>? items ;
  final Function(SectionItem?)? onChanged;
  final SectionItem? selectedValue;
  const SectionDropdown({super.key, this.width, this.border = false, required this.title, this.items, this.onChanged, this.selectedValue});

  @override
  State<SectionDropdown> createState() => _SectionDropdownState();
}

class _SectionDropdownState extends State<SectionDropdown> {


  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      border: Border.all(width: .5, color: Theme.of(context).hintColor), ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<SectionItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(widget.selectedValue?.sectionName?? widget.title.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),),
        items: widget.items != null?
        widget.items?.map((SectionItem item) => DropdownMenuItem<SectionItem>(
            value: item, child: Text(item.sectionName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))).toList():[],
        value: widget.items!.contains(widget.selectedValue)?  widget.selectedValue : null,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero,
            height: 40, width: widget.width?? 100),
        menuItemStyleData: const MenuItemStyleData(height: 40),
      ),
    );
  }
}
