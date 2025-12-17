

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/master_configuration/role/domain/models/role_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class RoleDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<RoleItem>? items ;
  final Function(RoleItem?)? onChanged;
  final RoleItem? selectedValue;
  const RoleDropdown({super.key, this.width, this.border = false, required this.title, this.items, this.onChanged, this.selectedValue});

  @override
  State<RoleDropdown> createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {


  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      border: Border.all(width: .5, color: Theme.of(context).hintColor), ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<RoleItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(widget.selectedValue?.name?? widget.title.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),),
        items: widget.items != null?
        widget.items?.map((RoleItem item) => DropdownMenuItem<RoleItem>(
            value: item, child: Text(item.name??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))).toList():[],
        value: widget.items!.contains(widget.selectedValue)? widget.selectedValue: null,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero,
            height: 40, width: widget.width?? 100),
        menuItemStyleData: const MenuItemStyleData(height: 40),
      ),
    );
  }
}
