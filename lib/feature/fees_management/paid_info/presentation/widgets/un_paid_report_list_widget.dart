import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/fees_management/paid_info/controller/paid_info_controller.dart';
import 'package:mighty_school/feature/fees_management/paid_info/domain/model/un_paid_report_model.dart';
import 'package:mighty_school/feature/fees_management/paid_info/presentation/widgets/un_paid_report_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class UnPaidReportListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const UnPaidReportListWidget({super.key, required this.scrollController});

  @override
  State<UnPaidReportListWidget> createState() => _UnPaidReportListWidgetState();
}

class _UnPaidReportListWidgetState extends State<UnPaidReportListWidget> {
  @override
  void initState() {
    Get.find<PaidInfoController>().getUnPaidReport();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: GetBuilder<PaidInfoController>(
        builder: (paidInfoController) {
          return Column(children: [


            if(ResponsiveHelper.isDesktop(context))...[
              const CustomDivider(),
              Row(spacing: Dimensions.paddingSizeSmall, children: [
                Expanded(child: Text('roll'.tr, style: textRegular.copyWith())),
                Expanded(child: Text('name'.tr, style: textRegular.copyWith())),
                Expanded(child: Text('due_details'.tr, style: textRegular.copyWith())),
                Expanded(child: Text('total_paid'.tr, style: textRegular.copyWith())),
              ],),
              const CustomDivider(),
            ],


            GetBuilder<PaidInfoController>(
                  builder: (paidInfoReportController) {
                    var unPaidInfo = paidInfoReportController.unPaidReportModel?.data?.studentData;
                    UnPaidReportModel? unPaidInfoModel = paidInfoReportController.unPaidReportModel;
                    return  unPaidInfoModel != null? (unPaidInfoModel.data!= null && unPaidInfoModel.data!.studentData!.isNotEmpty)?
                    ListView.builder(
                        itemCount: unPaidInfo?.length??0,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return UnPaidReportItemWidget(unPaidReportItem: unPaidInfo?[index], index: index);
                        }) :
                    Padding(padding: ThemeShadow.getPadding(),
                      child: const Center(child: NoDataFound()),):

                    Padding(padding: ThemeShadow.getPadding(),
                        child: const Center(child: CircularProgressIndicator()));
                  }
              ),
            ],
          );
        }
      ),
    );
  }
}
