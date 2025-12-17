import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/model/exam_model.dart';
import 'package:mighty_school/feature/exam_management/mark_config/presentation/widgets/grand_final_exam_item.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class GrandFinalWidget extends StatefulWidget {
  final ScrollController scrollController;
  const GrandFinalWidget({super.key, required this.scrollController});

  @override
  State<GrandFinalWidget> createState() => _GrandFinalWidgetState();
}

class _GrandFinalWidgetState extends State<GrandFinalWidget> {
  @override
  void initState() {
    Get.find<ExamController>().getExamList(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamController>(
        builder: (examController) {
         ExamModel? examModel = examController.examModel;
         var exam = examModel?.data;
          return Column(children: [

            if(ResponsiveHelper.isDesktop(context))...[
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
                child: Row(spacing: Dimensions.paddingSizeSmall, children: [

                  Text("#", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                  Expanded(child: Text("name".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  Text("action".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                ],
                ),
              ),
              const CustomDivider(),
            ],

            examModel != null ? (examModel.data!= null && examModel.data!.data!.isNotEmpty)?
            PaginatedListWidget(scrollController: widget.scrollController,
                onPaginate: (int? offset){
                  examController.getExamList(offset??1);
                }, totalSize: exam?.total??0,
                offset: exam?.currentPage??0,
                itemView: ListView.builder(
                    itemCount: exam?.data?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return GrandFinalExamItemWidget(index: index, examItem: exam?.data?[index]);
                    })): const NoDataFound() : const Center(child: Padding(padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator())),

          ],);
        }
    );
  }
}
