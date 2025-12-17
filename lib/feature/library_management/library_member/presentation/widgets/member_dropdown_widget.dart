

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/library_management/library_member/domain/model/library_member_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MemberDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<LibraryMemberItem>? items ;
  final Function(LibraryMemberItem?)? onChanged;
  final LibraryMemberItem? selectedValue;
  const MemberDropdown({super.key, this.width, this.border = false, required this.title, this.items, this.onChanged, this.selectedValue});

  @override
  State<MemberDropdown> createState() => _MemberDropdownState();
}

class _MemberDropdownState extends State<MemberDropdown> {


  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      border: Border.all(width: .5, color: Theme.of(context).hintColor), ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<LibraryMemberItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(widget.selectedValue?.user?.name?? widget.title.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),),
        items: widget.items != null?
        widget.items?.map((LibraryMemberItem item) => DropdownMenuItem<LibraryMemberItem>(
            value: item, child: Text("${item.libraryId}-${item.user?.name??''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))).toList():[],
        value: widget.items!.contains(widget.selectedValue)? widget.selectedValue: null,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero,
            height: 40, width: widget.width?? 100),
        menuItemStyleData: const MenuItemStyleData(height: 40),
      ),
    );
  }
}
