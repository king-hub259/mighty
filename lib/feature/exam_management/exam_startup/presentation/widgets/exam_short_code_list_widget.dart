import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_code_store_body.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_short_code_model.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/exam_short_code_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ExamShortCodeListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const ExamShortCodeListWidget({super.key, required this.scrollController});

  @override
  State<ExamShortCodeListWidget> createState() => _ExamShortCodeListWidgetState();
}

class _ExamShortCodeListWidgetState extends State<ExamShortCodeListWidget> {
  @override
  void initState() {
    Get.find<ExamStartupController>().getExamShortCodeList(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamStartupController>(
        builder: (examStartupController) {
          var examShortCode = examStartupController.examShortCodeModel?.data;
          ExamShortCodeModel? examShortCodeModel = examStartupController.examShortCodeModel;
          return Column(children: [

            if(ResponsiveHelper.isDesktop(context))
              const CustomTitle(title: "select_global_exam_code_list"),

            if(ResponsiveHelper.isDesktop(context))...[
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
                child: Row(children: [
                  SizedBox(width: 15, height: 15, child: Checkbox(value: examStartupController.isAllSelected,
                      onChanged: (val){
                    examStartupController.toggleAllSelection();
                      })),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(child: Text("title".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: Text("total_mark".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: Text("pass_mark".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: Text("accept_percent".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                ],
                ),
              ),
              const CustomDivider(),
            ],

            examShortCodeModel != null ? (examShortCodeModel.data!= null && examShortCodeModel.data!.data!.isNotEmpty)?
            PaginatedListWidget(scrollController: widget.scrollController,
                onPaginate: (int? offset){
                  examStartupController.getExamShortCodeList(offset??1);
                }, totalSize: examShortCode?.total??0,
                offset: examShortCode?.currentPage??0,
                itemView: ListView.builder(
                    itemCount: examShortCode?.data?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return ExamShortCodeItemWidget(index: index,
                        examShortCodeItem: examShortCode?.data?[index],);
                    })): const NoDataFound() : const Center(child: Padding(padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator())),

            const SizedBox(height: Dimensions.paddingSizeSmall),
            Align(alignment: Alignment.centerRight,
                child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
                  onTap: (){

                  int? classId = Get.find<ClassController>().selectedClassItem?.id;

                  List<int> selectedExamShortCode = [];
                  if(examStartupController.selectedCodeList.isNotEmpty){
                    selectedExamShortCode = examStartupController.selectedCodeList.map((e) => e.id!).toList();
                  }

                  if(classId == null){
                    showCustomSnackBar("select_class".tr);
                  }
                  else if(selectedExamShortCode.isEmpty){
                    showCustomSnackBar("select_exam".tr);
                  }
                  else{
                    ExamCodeStoreBody examCodeStoreBody = ExamCodeStoreBody(classId: classId, selectedCodes: selectedExamShortCode);
                    examStartupController.examCodeStore(examCodeStoreBody);
                  }
                  },
                  horizontalPadding: 20,
                  color: Theme.of(context).primaryColor,
                  child: examStartupController.isLoading?
                  const Center(child: CircularProgressIndicator()):
                  Text("confirm".tr, style: textRegular.copyWith(color: Colors.white)),))
          ],);
        }
    );
  }
}
