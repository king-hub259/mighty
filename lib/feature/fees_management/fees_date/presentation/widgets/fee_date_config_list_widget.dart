import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/heading_menu_widget.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/common/widget/section_header_with_path_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_date/controller/fees_date_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_date/domain/model/fees_date_model.dart';
import 'package:mighty_school/feature/fees_management/fees_date/presentation/widgets/fees_date_card_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/widgets/select_fees_head_widget.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/session_selection_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FeeDateConfigListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeeDateConfigListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeaderWithPath(sectionTitle: "fee_date_config".tr),

        CustomContainer(
          child: GetBuilder<FeesDateController>(
              initState: (val) => Get.find<FeesDateController>().getFeesDateList(1),
              builder: (feesDateController) {
                FeesDateModel? feesDateModel = feesDateController.feesDateModel;
                var feesDate = feesDateController.feesDateModel?.data;
                return Column(children: [

                  Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeSmall,  children: [
                    const Expanded(child: SelectSessionWidget()),
                    const Expanded(child: SelectFeesHeadWidget()),
                    Padding(padding: const EdgeInsets.only(bottom: 9),
                        child: SizedBox(width: 90, child: CustomButton(onTap: (){

                        }, text: "search".tr)))
                  ],),

                  const HeadingMenu(headings: ["name", "fee_payable_date", "fee_activation_date", "action"]),


                  feesDateModel != null? (feesDateModel.data!= null && feesDateModel.data!.data!.isNotEmpty)?
                  PaginatedListWidget(scrollController: scrollController,
                      onPaginate: (int? offset){
                        feesDateController.getFeesDateList(offset??1);
                      }, totalSize: feesDate?.total??0,
                      offset: feesDate?.currentPage??0,
                      itemView: ListView.separated(
                          itemCount: feesDate?.data?.length??0,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return FeesDateCardWidget(index: index,
                                feesDateItem: feesDate?.data?[index]);
                          }, separatorBuilder: (BuildContext context, int index) {
                        return const CustomDivider();
                      },)) :
                  Padding(padding: ThemeShadow.getPadding(),
                      child: const Center(child: NoDataFound())):

                  Padding(padding: ThemeShadow.getPadding(),
                      child: const Center(child: CircularProgressIndicator()))


                ],);
              }
          ),
        ),
      ],
    );
  }
}
