import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/domain/model/parent_paid_report_model.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_paid_report_item_widget.dart';
import 'package:mighty_school/util/styles.dart';



class ParentPaidReportListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const ParentPaidReportListWidget({super.key, required this.scrollController});

  @override
  State<ParentPaidReportListWidget> createState() => _ParentPaidReportListWidgetState();
}

class _ParentPaidReportListWidgetState extends State<ParentPaidReportListWidget> {
  @override
  void initState() {
    Get.find<ParentPaidInfoController>().getPaidFeeInfoList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentPaidInfoController>(
      builder: (paidInfoController) {
        return GetBuilder<ParentPaidInfoController>(
              builder: (paidInfoReportController) {
                var paidInfo = paidInfoReportController.paidReportModel?.data;
                ParentPaidReportModel? paidInfoModel = paidInfoReportController.paidReportModel;
                return  paidInfoModel != null? (paidInfoModel.data?.collectionHistory != null && paidInfoModel.data!.collectionHistory!.isNotEmpty)?
                ListView.builder(
                    itemCount: paidInfo?.collectionHistory?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return ParentPaidReportItemWidget(paidReportInfo: paidInfo?.collectionHistory?[index], index: index);
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
