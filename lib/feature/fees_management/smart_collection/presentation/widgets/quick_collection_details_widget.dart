import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/common/widget/horizontal_divider.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_selection_widget.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/domain/model/calculation_body.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/domain/model/smart_collection_body.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/domain/model/smart_collection_details_model.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/domain/model/sub_head_wise_collection_body.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/presentation/widgets/select_academic_year_widget.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class QuickCollectionDetailsWidget extends StatefulWidget {
  const QuickCollectionDetailsWidget({super.key});

  @override
  State<QuickCollectionDetailsWidget> createState() => _QuickCollectionDetailsWidgetState();
}

class _QuickCollectionDetailsWidgetState extends State<QuickCollectionDetailsWidget> {
  TextEditingController rollController = TextEditingController();
  @override
  void initState() {
    rollController.text = Get.find<SmartCollectionController>().smartCollectionDetailsModel?.data?.studentSession?.student?.rollNo?? '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartCollectionController>(
        builder: (smartCollection) {
          SmartCollectionDetailsModel? smartCollectionDetailsModel = smartCollection.smartCollectionDetailsModel;
          Student? student = smartCollectionDetailsModel?.data?.studentSession?.student;
          SmartItem? smartItem = smartCollectionDetailsModel?.data;
          return smartCollectionDetailsModel != null?
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              if(ResponsiveHelper.isDesktop(context))...[
                Row( children: [
                    const Expanded(child: SelectAcademicYearWidget()),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                     Expanded(child: CustomTextField(title: "roll".tr,
                      controller: rollController,
                      hintText: "1234",contentPadding: 13,)),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                    Padding(padding: const EdgeInsets.only(top: 37),
                      child: GetBuilder<SmartCollectionController>(
                          builder: (studentController) {
                            return SizedBox(width: 90, child: CustomButton(onTap: (){
                            }, text: "search", innerPadding: EdgeInsets.zero,));
                          }
                      ),
                    )
                  ],
                ),
              ],


               Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const CustomImage(image: "", width: 120, height: 120,),
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Text('${"name".tr}: ${student?.firstName??''} ${student?.lastName??''}'),
                    Text('${"roll".tr}: ${student?.rollNo??''}'),
                    Text('${"section".tr}: ${'api te section er data nai'}'),
                    Text('${"group".tr}: ${student?.studentGroup?.groupName??''}'),
                    Text('${"fathers_name".tr}: ${student?.fatherName??''}'),
                    Text('${"mothers_name".tr}: ${student?.motherName??''}'),
                    Text('${"category".tr}: ${student?.studentCategory?.name??''}'),
                    Text('${"phone".tr}: ${student?.phone??''}'),
                  ],)
                ]),
               const SizedBox(height: Dimensions.paddingSizeSmall),
              CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Column( children: [


                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: smartItem?.feeHeads?.length,
                    itemBuilder: (context, index){
                      List<FeeSubHeads>? subHeads = smartItem?.feeHeads?[index].feeSubHeads;
                      return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Text("${smartItem?.feeHeads?[index].name}"),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                            child: Container(width: 1,height: 20, color: Theme.of(context).hintColor,),),
                          Expanded(child: SizedBox(height: 40,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: subHeads?.length,
                                itemBuilder: (context, subIndex){
                                  return Padding(padding: const EdgeInsets.all(5.0),
                                    child: CustomContainer(color: subHeads![subIndex].selected! ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                                      onTap: ()=> smartCollection.toggleSelectionFeeSubHead(index, subIndex),
                                        horizontalPadding: Dimensions.paddingSizeSmall, verticalPadding: Dimensions.paddingSizeExtraSmall,borderRadius: Dimensions.paddingSizeExtraSmall,
                                        child: Text("${subHeads[subIndex].name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                            color: subHeads[subIndex].selected! ? Theme.of(context).cardColor : Theme.of(context).textTheme.displayLarge?.color,),)),
                                  );
                                }),
                          ))
                        ],
                      );
                    }),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Align(alignment: Alignment.centerRight,
                    child: SizedBox(width: 90,child: smartCollection.isLoading? const Center(child: CircularProgressIndicator()):
                    CustomButton(borderRadius: Dimensions.paddingSizeExtraSmall,innerPadding: EdgeInsets.zero,
                        onTap: (){
                          List<FeeHeadId>? feeHeadId = [];
                          if (smartItem?.feeHeads != null) {
                            for (var feeHead in smartItem!.feeHeads!) {
                              if (feeHead.feeSubHeads != null) {
                                var selectedSubHeads = feeHead.feeSubHeads!.where((sub) => sub.selected!).toList();
                                if (selectedSubHeads.isNotEmpty) {
                                  List<int> subHeadIds = selectedSubHeads.map((sub) => sub.id!).toList();
                                  feeHeadId.add(FeeHeadId(id: feeHead.id, feeSubHeadIds: subHeadIds));
                                }
                              }
                            }
                          }
                          log("ids==> $feeHeadId");

                          SubHeadWiseCollectionBody body = SubHeadWiseCollectionBody(
                            studentId: smartItem?.studentSession?.studentId, feeHeadId: feeHeadId);
                      smartCollection.getSubHeadWiseCalculation(body);
                        },
                        text: "confirm".tr)))


              ])),
               const SizedBox(height: Dimensions.paddingSizeSmall),
              CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Row( children: [
                 Expanded(child: Text("total_paid".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  const HorizontalDivider(),
                 Expanded(child: Text("waiver".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  const HorizontalDivider(),
                 Expanded(child: Text("fine_payable".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  const HorizontalDivider(),
                 Expanded(child: Text("fee_payable".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  const HorizontalDivider(),
                 Expanded(child: Text("fee_and_fine_payable".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                 const HorizontalDivider(),
                 Expanded(child: Text("total_payable".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),

              ])),

              const SizedBox(height: Dimensions.paddingSizeDefault),
              GetBuilder<SmartCollectionController>(
                builder: (smartCollectionController) {
                  List<CalculationModel> calculationModel = smartCollectionController.calculationModel;
                  return calculationModel.isNotEmpty?
                  CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,

                      child: ListView.builder(
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: calculationModel.length,
                          itemBuilder: (context, index){
                        return Row( children: [
                          CostItem(amount: calculationModel[index].amounts?.totalPaid??0),
                          const HorizontalDivider(),
                          CostItem(amount: calculationModel[index].amounts?.waiver??0),
                          const HorizontalDivider(),
                          CostItem(amount: calculationModel[index].amounts?.finePayable??0),
                          const HorizontalDivider(),
                          CostItem(amount: calculationModel[index].amounts?.feePayable??0),
                          const HorizontalDivider(),
                          CostItem(amount: calculationModel[index].amounts?.feeAndFinePayable??0),
                          const HorizontalDivider(),
                          CostItem(amount: calculationModel[index].amounts?.totalPayable??0),
                        ]);
                      })):const SizedBox();
                }
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              GetBuilder<SmartCollectionController>(
                builder: (smartCollectionController) {
                  return Row(children: [

                    FineWidget(title: "attendance_fine", amount: smartCollectionController.attendanceFineAmount,
                    value: smartCollectionController.attendanceFineChecked,
                    onTap: (val)=> smartCollectionController.toggleAttendanceFine()),

                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    FineWidget(title: "quiz_fine", amount: smartCollectionController.quizFineAmount,
                        value: smartCollectionController.quizFineChecked,
                        onTap: (val)=> smartCollectionController.toggleQuizFine()),

                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    FineWidget(title: "lab_fine", amount: smartCollectionController.labFineAmount,
                        value: smartCollectionController.labFineChecked,
                        onTap: (val)=> smartCollectionController.toggleLabFine()),

                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    FineWidget(title: "tc_amount", amount: smartCollectionController.tcChargeAmount,
                        value: smartCollectionController.tcChargeChecked,
                        onTap: (val)=> smartCollectionController.toggleTCCharge()),

                    ],
                  );
                }
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Expanded(flex: 1, child: DateSelectionWidget()),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                   Expanded(flex: 4, child: CustomTextField(
                     title: "comment".tr,
                       hintText: "comments".tr)),
                ],
              ),

              const SizedBox(height: Dimensions.paddingSizeDefault),

              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Expanded(flex:2, child: SelectAccountingLedgerWidget(title: 'paid_by',showBalance: true)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Row(children: [Switch(
                    value: smartCollection.sendSms, onChanged: (val){
                  smartCollection.toggleSendSms();
                    }), Text("sent_sms".tr)],),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                SizedBox(width : 180, child: smartCollection.isLoading? const Center(child: CircularProgressIndicator()):
                CustomButton(onTap: (){


                  List<FeeHead>? feeHeads = [];
                  feeHeads.addAll(
                      smartCollection.calculationModel.map((model) => FeeHead(
                        feeHeadId: model.feeHeadId.toString(),
                        subHeadIds: model.feeSubHeads,
                        totalPaid: model.amounts?.totalPaid.toString(),
                        waiver: model.amounts?.waiver.toString(),
                        finePayable: model.amounts?.finePayable.toString(),
                        feePayable: model.amounts?.feePayable.toString(),
                        feeAndFinePayable: model.amounts?.feeAndFinePayable.toString(),
                        previousDuePaid: model.amounts?.previousDuePaid.toString(),
                        previousDuePayable: model.amounts?.previousDuePayable.toString(),
                        totalPayable: model.amounts?.totalPayable.toString(),
                      ))
                  );
                  double totalPayable = 0.0;
                  double totalPaid = 0.0;
                  for (var model in smartCollection.calculationModel) {
                    totalPayable += model.amounts?.totalPayable ?? 0.0;
                    totalPaid += model.amounts?.totalPaid ?? 0.0;
                  }
                  totalPayable += smartCollection.quizFineAmount + smartCollection.attendanceFineAmount + smartCollection.labFineAmount + smartCollection.tcChargeAmount;

                  SmartCollectionBody body =  SmartCollectionBody(
                    studentId: smartItem?.studentSession?.studentId,
                    feeHeads: feeHeads,
                    attendanceFine: smartCollection.attendanceFineAmount,
                    quizFine: smartCollection.quizFineAmount,
                    totalPaid: totalPaid.toString(),
                    totalPayable: totalPayable.toString(),
                    smsStatus: smartCollection.sendSms? "1" : "0",
                    tcAmount: smartCollection.tcChargeAmount,
                    date: Get.find<DatePickerController>().formatedDate,
                    ledgerId: 1,
                    note: ""
                  );

                  if(totalPayable>0){
                    smartCollection.collectSmartCollection(body);
                  }else{
                    showCustomSnackBar("invalid_request".tr);
                  }
                }, text: "process_to_collection".tr)),
              ],
              )

            ],),
          ): const Center(child: CircularProgressIndicator());
        }
    );
  }
}
class CostItem extends StatelessWidget {
  final double amount;
  const CostItem({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(PriceConverter.convertPrice(context, amount), style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)));
  }
}

class FineWidget extends StatelessWidget {
  final String title;
  final double amount;
  final bool value;
  final Function(dynamic)? onTap;
  const FineWidget({super.key, required this.title, required this.amount, this.onTap, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,horizontalPadding: 5,verticalPadding: 5,child: Row(children: [
      SizedBox(width: 20, child: Checkbox(value: value, onChanged: onTap)),
      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
      Text("${title.tr}: ", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
      Text(PriceConverter.convertPrice(context, amount),style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))
    ])),
    );
  }
}
