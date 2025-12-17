import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/parent_module/children/domain/model/children_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ChildrenDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<ChildrenItem>? items ;
  final Function(ChildrenItem?)? onChanged;
  final ChildrenItem? selectedValue;
  const ChildrenDropdown({super.key, this.width, this.border = false, required this.title, this.items, this.onChanged, this.selectedValue});

  @override
  State<ChildrenDropdown> createState() => _ChildrenDropdownState();
}

class _ChildrenDropdownState extends State<ChildrenDropdown> {


  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      border: Border.all(width: .5, color: Theme.of(context).hintColor), ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<ChildrenItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(widget.selectedValue?.firstName?? widget.title.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),),
        items: widget.items != null?
        widget.items?.map((ChildrenItem item) => DropdownMenuItem<ChildrenItem>(
            value: item, child: Text(item.firstName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))).toList():[],
        value: widget.items!.contains(widget.selectedValue)? widget.selectedValue : null,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero,
            height: 35, width: widget.width?? 100),
        menuItemStyleData: const MenuItemStyleData(height: 35),
      ),
    );
  }
}
