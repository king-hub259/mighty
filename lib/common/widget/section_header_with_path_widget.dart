import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_add_new_button_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

import 'custom_route_path_widget.dart';

class SectionHeaderWithPath extends StatelessWidget {
  final String sectionTitle;
  final List<String>? pathItems;
  final String? addNewTitle;
  final VoidCallback? onAddNewTap;


  const SectionHeaderWithPath({super.key, required this.sectionTitle,  this.pathItems,  this.addNewTitle,  this.onAddNewTap,});

  @override
  Widget build(BuildContext context) {
    return (ResponsiveHelper.isDesktop(context))?
    Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: CustomRoutePathWidget(title: sectionTitle.tr,
        subWidget: Row(children: [
          if(pathItems != null && pathItems!.isNotEmpty)
            ...pathItems!.map((item) => Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
              child: PathItemWidget(title: item.tr))),

            if (addNewTitle != null && onAddNewTap != null)
            CustomAddNewButtonWidget(title: addNewTitle!.tr, onTap: onAddNewTap),
          ],
        ),
      ),
    ):const SizedBox();
  }
}
