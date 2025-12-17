import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/menu_section/domain/model/custom_menu_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CustomBottomMenuWidget extends StatelessWidget {
   final CustomMenuModel customMenuModel;
  const CustomBottomMenuWidget({super.key, required this.customMenuModel});

  @override
  Widget build(BuildContext context) {
    return  ExpansionTile(
      leading: SizedBox(width: 30, child: Image.asset(customMenuModel.icon)),
      collapsedBackgroundColor: Theme.of(context).cardColor,
      backgroundColor: Theme.of(context).cardColor,
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOver),
      title: Text(customMenuModel.title,),
      children: generateItems(customMenuModel.subMenus),
    );
  }
   List<Widget> generateItems(List<SubMenu>? item) {

     List<Widget> items = [];
     if(item != null && item.isNotEmpty){
       for(int index = 0; index < item.length; index++) {
         items.add(TextButton(onPressed: () {

         }, child: Row(children: [
           SizedBox(width: 17,child: Image.asset(item[index].icon)),
           const SizedBox(width: Dimensions.paddingSizeSmall,),
           Text(item[index].title, style: textRegular.copyWith(color: Theme.of(Get.context!).textTheme.bodyMedium?.color),)
         ],),),);
       }
     }
     return items;
   }

}
