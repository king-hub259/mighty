import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/exam_management/remark_config/controller/re_mark_config_controller.dart';
import 'package:mighty_school/feature/exam_management/remark_config/domain/model/remark_config_model.dart';
import 'package:mighty_school/feature/exam_management/remark_config/presentation/widgets/create_new_remark_config_dialog.dart';
import 'package:mighty_school/feature/exam_management/remark_config/presentation/widgets/remrk_config_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ReMarkConfigListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const ReMarkConfigListWidget({super.key, required this.scrollController});

  @override
  State<ReMarkConfigListWidget> createState() => _ReMarkConfigListWidgetState();
}

class _ReMarkConfigListWidgetState extends State<ReMarkConfigListWidget> {
  @override
  void initState() {
    Get.find<ReMarkConfigController>().getRemarkConfigList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReMarkConfigController>(
        builder: (remarkConfigController) {
          ReMarkConfigModel? reMarkConfigModel = remarkConfigController.reMarkConfigModel;
          var remark = remarkConfigController.reMarkConfigModel?.data;
          return CustomContainer(showShadow: false, color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent,
            child: Column(children: [
              if(ResponsiveHelper.isDesktop(context))...[

                CustomTitle(title: "remark_config_list", widget: SizedBox(width: 120, child: CustomButton(onTap: (){
                  Get.dialog(const CreateNewReMarkConfigDialog());
                }, text: "add".tr)),),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                const CustomDivider(),
                Row(children: [
                  SizedBox(width: 120, child: Text("title".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  Expanded(child: Text("remark".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  SizedBox(width: 70,child: Text("action".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),

                ],),
                const CustomDivider(),
              ],


              reMarkConfigModel != null? (reMarkConfigModel.data!= null && reMarkConfigModel.data!.data!.isNotEmpty)?
              PaginatedListWidget(scrollController: widget.scrollController,
                  onPaginate: (int? offset) async{
                    remarkConfigController.getRemarkConfigList(offset??1);
                  }, totalSize: remark?.total??0,
                  offset: remark?.currentPage??0,
                  itemView: ListView.builder(
                      itemCount: remark?.data?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return ReMarkConfigItemWidget(index: index,
                          remarkConfigItem: remark?.data?[index],);
                      })):
              Padding(padding: EdgeInsets.symmetric(vertical: Get.height/2),
                child: const Center(child: NoDataFound()),
              ):
              Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator()),
            ],),
          );
        }
    );
  }
}
