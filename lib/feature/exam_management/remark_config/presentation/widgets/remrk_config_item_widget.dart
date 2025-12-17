import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/exam_management/remark_config/controller/re_mark_config_controller.dart';
import 'package:mighty_school/feature/exam_management/remark_config/domain/model/remark_config_model.dart';
import 'package:mighty_school/feature/exam_management/remark_config/presentation/widgets/create_new_remark_config_dialog.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ReMarkConfigItemWidget extends StatelessWidget {
  final RemarkConfigItem? remarkConfigItem;
  final int index;
  const ReMarkConfigItemWidget({super.key, this.remarkConfigItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: Column(children: [
          Row(children: [
              Expanded(flex:1,child: Text("${remarkConfigItem?.remarkTitle}",maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
              Expanded(flex: 7,child: Text("${remarkConfigItem?.remarks}",maxLines: 2,overflow: TextOverflow.ellipsis,
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
              EditDeleteSection(horizontal: true, onEdit: (){
                Get.dialog(CreateNewReMarkConfigDialog(remarkConfigItem: remarkConfigItem));
              },
                onDelete: (){
                  Get.dialog(ConfirmationDialog(
                    title: 'remark_config',
                    content: 'remark_config',
                    onTap: () {
                      Get.find<ReMarkConfigController>().deleteReMarkConfig(remarkConfigItem!.id!);
                    },));
              },)
            ],),
          const CustomDivider(verticalPadding: Dimensions.paddingSizeExtraSmall,)
        ],
      ),

    );
  }
}