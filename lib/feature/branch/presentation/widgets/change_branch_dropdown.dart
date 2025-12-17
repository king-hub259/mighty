

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/branch/domain/models/branch_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ChangeBranchDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<BranchItem>? items ;
  final Function(BranchItem?)? onChanged;
  final BranchItem? selectedValue;
  const ChangeBranchDropdown({super.key, this.width, this.border = false, required this.title, this.items, this.onChanged, this.selectedValue});

  @override
  State<ChangeBranchDropdown> createState() => _ChangeBranchDropdownState();
}

class _ChangeBranchDropdownState extends State<ChangeBranchDropdown> {


  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      border: Border.all(width: .5, color: Theme.of(context).hintColor), ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<BranchItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(widget.selectedValue?.name?? widget.title.tr, maxLines: 1,overflow: TextOverflow.ellipsis,
          style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),),
        items: widget.items != null?
        widget.items?.map((BranchItem item) => DropdownMenuItem<BranchItem>(
            value: item, child: Text(item.name??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))).toList():[],
        value: widget.selectedValue,
        onChanged: widget.onChanged,

        buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero,
            height: 35, width: widget.width?? 100),
        menuItemStyleData: const MenuItemStyleData(height: 35),
      ),
    );
  }
}
