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
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_grade_model.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/model/exam_grade_store_body.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/presentation/widgets/exam_grade_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ExamGradeListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const ExamGradeListWidget({super.key, required this.scrollController});

  @override
  State<ExamGradeListWidget> createState() => _ExamGradeListWidgetState();
}

class _ExamGradeListWidgetState extends State<ExamGradeListWidget> {
  @override
  void initState() {
    Get.find<ExamStartupController>().getExamGradeList(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamStartupController>(
        builder: (examStartupController) {
          var examGrade = examStartupController.examGradeModel?.data;
          ExamGradeModel? examShortCodeModel = examStartupController.examGradeModel;
          return Column(children: [

            if(ResponsiveHelper.isDesktop(context))
              const CustomTitle(title: "select_global_exam_grade_list"),

            if(ResponsiveHelper.isDesktop(context))...[
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
                child: Row(children: [
                  SizedBox(width: 15, height: 15, child: Checkbox(value: examStartupController.isAllGradeSelected,
                      onChanged: (val){
                    examStartupController.toggleAllGradeSelected();
                      })),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(child: Text("grade".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: Text("grade_range".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                ],
                ),
              ),
              const CustomDivider(),
            ],

            examShortCodeModel != null ? (examShortCodeModel.data!= null && examShortCodeModel.data!.data!.isNotEmpty)?
            PaginatedListWidget(scrollController: widget.scrollController,
                onPaginate: (int? offset){
                  examStartupController.getExamGradeList(offset??1);
                }, totalSize: examGrade?.total??0,
                offset: examGrade?.currentPage??0,
                itemView: ListView.builder(
                    itemCount: examGrade?.data?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return ExamGradeItemWidget(index: index, examGradeItem: examGrade?.data?[index]);
                    })): const NoDataFound() : const Center(child: Padding(padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator())),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Align(alignment: Alignment.centerRight,
                child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
                  onTap: (){

                    int? classId = Get.find<ClassController>().selectedClassItem?.id;

                    List<String> selectedGrades = [];
                    if(examStartupController.selectedGradeList.isNotEmpty){
                      selectedGrades = examStartupController.selectedGradeList.map((e) => e.id!.toString()).toList();
                    }

                    if(classId == null){
                      showCustomSnackBar("select_class".tr);
                    }
                    else if(selectedGrades.isEmpty){
                      showCustomSnackBar("select_grade".tr);
                    }
                    else{
                      ExamGradeStoreBody body = ExamGradeStoreBody(classId: classId.toString(), selectedGrades: selectedGrades);
                      examStartupController.examGradeStore(body);
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
