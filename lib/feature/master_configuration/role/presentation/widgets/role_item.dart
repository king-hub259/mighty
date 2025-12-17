
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/theme_controller.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/master_configuration/role/domain/models/role_model.dart';
import 'package:mighty_school/feature/master_configuration/role/presentation/screens/create_new_role_screen.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class RoleItemWidget extends StatelessWidget {
  final RoleItem? roleItem;
  const RoleItemWidget({super.key, this.roleItem});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
          ExpansionTile(backgroundColor: Theme.of(context).cardColor,

            title: Row(children: [
              Expanded(child: Text("${roleItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
              InkWell(onTap: (){
                Get.to(()=> CreateNewRoleScreen(roleItem: roleItem));
              },
                  child: SizedBox(width: 15, child: Image.asset(Images.editIcon))),
            ],
            ),
            children: [
              if(roleItem!.permissions != null && roleItem!.permissions!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(direction: Axis.horizontal, alignment : WrapAlignment.start,
                    children: [for (int index =0; index < roleItem!.permissions!.length; index++)
                      Padding(padding:  const EdgeInsets.symmetric(vertical: 5),
                        child: Container(decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                            color: Get.find<ThemeController>().darkTheme? Colors.grey.withValues(alpha: 0.2): Theme.of(context).primaryColor.withValues(alpha: .1)),
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall-3, horizontal: Dimensions.paddingSizeSmall),
                          margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.85),
                            child: Row(mainAxisSize:MainAxisSize.min,children: [
                              Flexible(child: Text(roleItem?.permissions?[index].name??'',
                                  style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                                  overflow: TextOverflow.ellipsis)),
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ],),
        const CustomDivider(),
        ],
      ):
      CustomContainer(horizontalPadding: 0, verticalPadding: 0,
          child: ExpansionTile(
            title: Row(children: [
                Expanded(child: Text("${roleItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                InkWell(onTap: (){
                  Get.to(()=> CreateNewRoleScreen(roleItem: roleItem));
                },
                    child: SizedBox(width: 15, child: Image.asset(Images.editIcon))),
              ],
            ),
          children: [
            if(roleItem!.permissions != null && roleItem!.permissions!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(direction: Axis.horizontal, alignment : WrapAlignment.start,
                children: [for (int index =0; index < roleItem!.permissions!.length; index++)
                  Padding(padding:  const EdgeInsets.symmetric(vertical: 5),
                    child: Container(decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        color: Get.find<ThemeController>().darkTheme? Colors.grey.withValues(alpha: 0.2): Theme.of(context).primaryColor.withValues(alpha: .1)),
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall-3, horizontal: Dimensions.paddingSizeSmall),
                      margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.85),
                        child: Row(mainAxisSize:MainAxisSize.min,children: [
                          Flexible(child: Text(roleItem?.permissions?[index].name??'',
                              style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                              overflow: TextOverflow.ellipsis)),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],)),
    );
  }
}