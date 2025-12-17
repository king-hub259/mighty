import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/parent_module/children/controller/children_controller.dart';
import 'package:mighty_school/feature/parent_module/children/presentation/widgets/children_item_widget.dart';
import 'package:mighty_school/util/styles.dart';


class ChildrenListWidget extends StatelessWidget {
  const ChildrenListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChildrenController>(
        builder: (childrenController) {
          var childrenModel = childrenController.childrenModel;
          return  childrenModel != null? (childrenModel.data!= null && childrenModel.data!.isNotEmpty)?
          GridView.builder(
              itemCount: childrenModel.data?.length??0,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ChildrenItemWidget(childrenItem: childrenModel.data?[index], index: index);
              }, gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: Get.width)) :
          Padding(padding: ThemeShadow.getPadding(),
            child: const Center(child: NoDataFound()),):

          Padding(padding: ThemeShadow.getPadding(),
              child: const Center(child: CircularProgressIndicator()));
        }
    );
  }
}
