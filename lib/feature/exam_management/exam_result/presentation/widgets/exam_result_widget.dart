import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/exam_management/exam_result/controller/exam_result_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_result/domain/models/exam_result_model.dart';
import 'package:mighty_school/feature/exam_management/exam_result/presentation/widgets/exam_result_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ExamResultWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ExamResultWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: GetBuilder<ExamResultController>(
        builder: (examResultController) {
          ExamResultModel? examResultModel = examResultController.examResultModel;
          var examResult = examResultModel?.data;
          return Column(children: [
            CustomTitle(title: "exam_result".tr, fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600),

            if(ResponsiveHelper.isDesktop(context))...[
              const CustomDivider(verticalPadding: Dimensions.paddingSizeSmall),
              Row( children: [
                Expanded(child: Text('exam_code_title'.tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text("total".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text("pass_mark".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text("acceptance".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),))
              ],),
              const CustomDivider(verticalPadding: Dimensions.paddingSizeSmall),
            ],

            examResultModel != null? (examResultModel.data!= null && examResultModel.data!.data!.isNotEmpty)?
            ListView.builder(
                itemCount: examResult?.data?.length??0,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return ExamResultItemWidget(resultItem: examResult?.data?[index]);
                }) :
            Padding(padding: EdgeInsets.only(top: Get.height/2),
              child: const Center(child: NoDataFound())):

            const SizedBox(),
          ],);
        }
      ),
    );
  }
}
