import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/fees_management/paid_info/controller/paid_info_controller.dart';
import 'package:mighty_school/feature/fees_management/paid_info/domain/model/paid_report_model.dart';
import 'package:mighty_school/feature/fees_management/paid_info/presentation/widgets/paid_report_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class PaidReportListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const PaidReportListWidget({super.key, required this.scrollController});

  @override
  State<PaidReportListWidget> createState() => _PaidReportListWidgetState();
}

class _PaidReportListWidgetState extends State<PaidReportListWidget> {
  @override
  void initState() {
    Get.find<PaidInfoController>().getPaidFeeInfoList(Get.find<DatePickerController>().formatedDate, Get.find<DatePickerController>().formatedEndDate);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: GetBuilder<PaidInfoController>(
        builder: (paidInfoController) {
          return Column(children: [

            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
               Expanded(child: DateSelectionWidget(title: "from_date".tr)),
              const SizedBox(width: Dimensions.paddingSizeSmall),
               Expanded(child: DateSelectionWidget(end: true, title: "to_date".tr)),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              SizedBox(width: 90, child: CustomButton(onTap: (){
                paidInfoController.getPaidFeeInfoList(Get.find<DatePickerController>().formatedDate, Get.find<DatePickerController>().formatedEndDate);
              }, text: "search"),),
            ]),



            if(ResponsiveHelper.isDesktop(context))...[
              const CustomDivider(),
              Row(spacing: Dimensions.paddingSizeSmall, children: [
                Expanded(child: Text('roll'.tr, style: textRegular.copyWith())),
                Expanded(child: Text('name'.tr, style: textRegular.copyWith())),
                Expanded(child: Text('invoice'.tr, style: textRegular.copyWith())),
                Expanded(child: Text('total_payable'.tr, style: textRegular.copyWith())),
                Expanded(child: Text('total_paid'.tr, style: textRegular.copyWith())),
              ],),
              const CustomDivider(),
            ],


            // Paid Info List Section
            Expanded(
              child: GetBuilder<PaidInfoController>(
                builder: (paidInfoReportController) {
                  var paidInfo = paidInfoReportController.paidReportModel?.data;
                  PaidReportModel? paidInfoModel = paidInfoReportController.paidReportModel;

                  return paidInfoModel != null ?
                    (paidInfoModel.data != null && paidInfoModel.data!.isNotEmpty) ?
                      ListView.builder(
                        controller: widget.scrollController,
                        itemCount: paidInfo?.length ?? 0,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return PaidReportItemWidget(paidReportInfo: paidInfo?[index], index: index);
                        }
                      ) :
                      const Center(child: NoDataFound()) :
                    const Center(child: CircularProgressIndicator());
                }
              ),
            ),
            ],
          );
        }
      ),
    );
  }
}
