import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/sms/phone_book_category/domain/models/phone_book_category_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PhoneBookCategoryDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<PhoneBookCategoryItem>? items ;
  final Function(PhoneBookCategoryItem?)? onChanged;
  final PhoneBookCategoryItem? selectedValue;
  const PhoneBookCategoryDropdown({super.key, this.width, this.border = false, required this.title, this.items, this.onChanged, this.selectedValue});

  @override
  State<PhoneBookCategoryDropdown> createState() => _PhoneBookCategoryDropdownState();
}

class _PhoneBookCategoryDropdownState extends State<PhoneBookCategoryDropdown> {


  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      border: Border.all(width: .5, color: Theme.of(context).hintColor), ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<PhoneBookCategoryItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(widget.selectedValue?.name?? widget.title.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),),
        items: widget.items != null?
        widget.items?.map((PhoneBookCategoryItem item) => DropdownMenuItem<PhoneBookCategoryItem>(
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
