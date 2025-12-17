import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/parent_module/children/controller/children_controller.dart';
import 'package:mighty_school/feature/parent_module/children/domain/model/children_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SwitchChildrenDialog extends StatelessWidget {
  const SwitchChildrenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChildrenController>(
      initState: (state) {
        if(Get.find<ChildrenController>().childrenModel == null) {
          Get.find<ChildrenController>().getChildrenList();
        }
      },
      builder: (controller) {
        ChildrenModel? childrenModel = controller.childrenModel;
        return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(spacing: Dimensions.paddingSizeDefault, mainAxisSize: MainAxisSize.min,children: [
              const Text("Switch Children's",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: childrenModel?.data?.length??0,
                  itemBuilder: (context, index) {
                    return ChildrenCard( data: childrenModel?.data?[index]);
                  } ,),
              )
              ,
            ],
          ),
        );
      },
    );
  }
}

class ChildrenCard extends StatelessWidget {
  const ChildrenCard({super.key, this.data});
  final ChildrenItem? data;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: ()=> Get.find<ChildrenController>().setSelectChildren(data),
      child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        child: CustomContainer(showShadow: false, borderColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
          child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
             const CustomImage(height: 30,width: 30,radius: Dimensions.radiusOverLarge,) ,

            Expanded(child: Column(spacing: Dimensions.paddingSizeExtraSmall,
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(data?.lastName?? '',style:  textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w600)),

                Text("${"class".tr} : ${data?.className?? ''}   ${"section".tr}: ${data?.sectionName?? ''}",
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),],),),


            ],
          ),
        ),
      ),
    );
  }
}