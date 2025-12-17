
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/master_configuration/role/controller/role_controller.dart';
import 'package:mighty_school/feature/master_configuration/role/presentation/widgets/create_new_role_widget.dart';
import 'package:mighty_school/feature/master_configuration/role/presentation/widgets/role_item.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class RoleListWidget extends StatelessWidget {
  const RoleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoleController>(
      initState: (val)=> Get.find<RoleController>().getRoleList(1),
        builder: (roleController) {

          return CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,
            showShadow: false, borderRadius: Dimensions.paddingSizeExtraSmall,
            child: Column(children: [
              if(ResponsiveHelper.isDesktop(context))...[
                CustomTitle(title: "role_list", widget: SizedBox(width: 120, child: CustomButton(onTap: (){
                  showModalBottomSheet(context: context, isScrollControlled: true,
                     constraints: BoxConstraints(maxWidth:  Get.width),
                    builder: (_) {
                    return Container(width: Get.width-120,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
                          color: Theme.of(context).cardColor),
                      child: const SingleChildScrollView(child: CreateNewRoleWidget()));
                  }, );
                }, text: "add".tr)),),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                const CustomDivider(),

              ],
              roleController.roleModel != null? (roleController.roleModel!.data!= null && roleController.roleModel!.data!.data!.isNotEmpty)?
              ListView.builder(itemCount: roleController.roleModel?.data?.data?.length??0,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return RoleItemWidget(roleItem: roleController.roleModel?.data?.data?[index],);
                  }) :

              Padding(padding: ThemeShadow.getPadding(),
                child: const Center(child: NoDataFound()),):

              Padding(padding: ThemeShadow.getPadding(),
                  child: const CircularProgressIndicator()),
            ],),
          );
        }
    );
  }
}
