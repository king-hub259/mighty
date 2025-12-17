import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/presentation/widgets/accounting_fund_selection_widget.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_selection_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_head/presentation/widgets/select_fees_head_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/controller/fees_mapping_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/domain/model/fees_mapping_body.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/controller/fees_sub_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/presentation/widgets/select_fees_sub_sub_head_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewFeeMappingWidget extends StatefulWidget {
  const CreateNewFeeMappingWidget({super.key});

  @override
  State<CreateNewFeeMappingWidget> createState() => _CreateNewFeeMappingWidgetState();
}

class _CreateNewFeeMappingWidgetState extends State<CreateNewFeeMappingWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesMappingController>(
      builder: (feesMappingController) {
        return  Column(mainAxisSize: MainAxisSize.min, children: [
          const SelectFeesHeadWidget(),
            const SelectFeesSubHeadWidget(),
          const SelectAccountingLedgerWidget(title: "ledger"),
          const SelectAccountingFundWidget(title: "fund"),

          SizedBox(width: 120, child: feesMappingController.isLoading? const Center(child: CircularProgressIndicator()):
          CustomButton(onTap: (){

            int? feesHeadId = Get.find<FeesHeadController>().selectedFeesHeadItem?.id;
            int? feesSubHeadId = Get.find<FeesSubHeadController>().selectedFeesSubHeadItem?.id;
            int? accountingLedgerId = Get.find<AccountLedgerController>().selectedAccountingLedgerItemForTransaction?.id;
            int? accountingFundId = Get.find<AccountingFundController>().selectedAccountingFundItem?.id;

            if(feesHeadId == null){
              showCustomSnackBar("select_fee_head".tr);
            }else if(feesSubHeadId == null){
              showCustomSnackBar("select_fees_sub_head".tr);
            }else if(accountingLedgerId == null){
              showCustomSnackBar("select_ledger".tr);
            }
            else if(accountingFundId == null){
              showCustomSnackBar("select_fund".tr);
            }else{
              FeesMappingBody feesMappingBody = FeesMappingBody(
                  feeHeadId: feesHeadId.toString(),
                  feeSubHeadIds: [feesSubHeadId],
                  ledgerId: accountingLedgerId.toString(),
                  fundIds: [accountingFundId],
                  type: feesMappingController.feesStartupTypeIndex == 0?"fee":"fee_fine");

              feesMappingController.feesStartupTypeIndex == 0?
              feesMappingController.addNewFeesMapping(feesMappingBody):
              feesMappingController.addNewFeesMapping(feesMappingBody);
            }
          }, text: "confirm".tr),),
        ],);
      }
    );
  }
}
