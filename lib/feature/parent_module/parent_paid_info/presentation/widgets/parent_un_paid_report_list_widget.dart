import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/domain/model/parent_un_paid_report_model.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_un_paid_report_item_widget.dart';
import 'package:mighty_school/util/styles.dart';



class ParentUnPaidReportListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const ParentUnPaidReportListWidget({super.key, required this.scrollController});

  @override
  State<ParentUnPaidReportListWidget> createState() => _ParentUnPaidReportListWidgetState();
}

class _ParentUnPaidReportListWidgetState extends State<ParentUnPaidReportListWidget> {
  @override
  void initState() {
    Get.find<ParentPaidInfoController>().getUnPaidReport();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentPaidInfoController>(
      builder: (paidInfoController) {
        return GetBuilder<ParentPaidInfoController>(
              builder: (paidInfoReportController) {
                var unPaidInfo = paidInfoReportController.unPaidReportModel?.data?.studentData;
                ParentUnPaidReportModel? unPaidInfoModel = paidInfoReportController.unPaidReportModel;
                return  unPaidInfoModel != null? (unPaidInfoModel.data?.studentData?.feeHeads != null && unPaidInfoModel.data!.studentData!.feeHeads!.isNotEmpty)?
                ListView.builder(
                    itemCount: unPaidInfo?.feeHeads?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return ParentUnPaidReportItemWidget(unPaidReportItem: unPaidInfo?.feeHeads?[index], index: index);
                    }) :
                Padding(padding: ThemeShadow.getPadding(),
                  child: const Center(child: NoDataFound()),):

                Padding(padding: ThemeShadow.getPadding(),
                    child: const Center(child: CircularProgressIndicator()));
              }
          );
      }
    );
  }
}
