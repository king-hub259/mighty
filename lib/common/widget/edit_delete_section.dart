import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/theme_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class EditDeleteSection extends StatelessWidget {
  final Function()? onEdit;
  final Function()? onDelete;
  final Function()? idCard;
  final Function()? details;
  final Function(dynamic)? onChange;
  final bool horizontal;
  final bool actionValue;
  const EditDeleteSection({super.key, this.onEdit, this.onDelete, this.idCard, this.details, this.horizontal = false,
    this.onChange,  this.actionValue = true});

  @override
  Widget build(BuildContext context) {
    bool darkTheme = Get.find<ThemeController>().darkTheme;
    return horizontal?
    Row(children: [
      if(onEdit != null)
        InkWell(onTap: onEdit,
            child: SizedBox(width: 15,child: Image.asset(Images.editIcon, color:  darkTheme? Colors.white : Colors.black,))),

      if(onDelete != null)
      const SizedBox(width: Dimensions.paddingSizeLarge),
      if(onDelete != null)
      InkWell(onTap: onDelete,
          child: SizedBox(width: 20,child: Image.asset(Images.deleteIcon))),

      if(idCard != null)
        const SizedBox(width: Dimensions.paddingSizeLarge),
      if(idCard != null)
        InkWell(onTap: idCard,
            child: SizedBox(width: 20,child: Image.asset(Images.idCard))),

      if(details != null)
        const SizedBox(width: Dimensions.paddingSizeLarge),
      if(details != null)
        InkWell(onTap: details,
            child:  SizedBox(width: 20,child: Icon(Icons.remove_red_eye, color: Theme.of(context).hintColor,))),

      if(onChange != null)
        Theme(data: ThemeData(useMaterial3: false),
        child: SizedBox(height: 20,
          child: Switch(value: actionValue, onChanged: onChange,
            activeColor: Theme.of(context).primaryColor,
            inactiveTrackColor: Theme.of(context).hintColor, inactiveThumbColor: Theme.of(context).hintColor,),
        ))


    ],):
    Column(children: [
      if(onEdit != null)
      InkWell(onTap: onEdit,
          child: SizedBox(width: 20,child: Image.asset(Images.editIcon, color:  darkTheme? Colors.white : Colors.black,))),

      if(onDelete != null)
      const SizedBox(height: Dimensions.paddingSizeLarge),
      if(onDelete != null)
      InkWell(onTap: onDelete,
          child: SizedBox(width: 20,child: Image.asset(Images.deleteIcon))),

      if(idCard != null)
      const SizedBox(height: Dimensions.paddingSizeLarge),
      if(idCard != null)
        InkWell(onTap: idCard,
            child: SizedBox(width: 20,child: Image.asset(Images.idCard))),

      if(details != null)
      const SizedBox(height: Dimensions.paddingSizeLarge),
      if(details != null)
        InkWell(onTap: details,
            child:  SizedBox(width: 20,child: Icon(Icons.remove_red_eye, color: Theme.of(context).hintColor,))),
      if(onChange != null)
        const SizedBox(height: Dimensions.paddingSizeLarge),
      if(onChange != null)
        Switch(value: actionValue, onChanged: onChange)


    ],);
  }
}
