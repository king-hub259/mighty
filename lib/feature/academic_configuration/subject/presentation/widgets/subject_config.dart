import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:mighty_school/feature/academic_configuration/subject/presentation/widgets/subject_config_item_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class SubjectConfigWidget extends StatefulWidget {
  final ScrollController scrollController;
  const SubjectConfigWidget({super.key, required this.scrollController});

  @override
  State<SubjectConfigWidget> createState() => _SubjectConfigWidgetState();
}

class _SubjectConfigWidgetState extends State<SubjectConfigWidget> {
  @override
  void initState() {
    Get.find<SubjectController>().getSubjectList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(children: [
       const Row(children: [
         Expanded(child: SelectClassWidget()),
         SizedBox(width: Dimensions.paddingSizeSmall),
         Expanded(child: SelectGroupWidget()),
       ]),

        GetBuilder<SubjectController>(
            builder: (subjectController) {
              var subject = subjectController.subjectModel?.data;
              SubjectModel? subjectModel = subjectController.subjectModel;
              return PaginatedListWidget(
                scrollController: widget.scrollController,
                onPaginate: (int? offset) async {
                  await subjectController.getSubjectList(offset?? 1);
                },
                totalSize: subject?.total??0,
                offset: subject?.currentPage??1,
                itemView: Column(children: [
                  subjectModel != null? (subjectModel.data!= null && subjectModel.data!.data!.isNotEmpty)?
                  MasonryGridView.count(
                      itemCount: subject?.data?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return SubjectConfigItemWidget(index: index, subjectItem: subject?.data?[index],);
                      }, crossAxisCount: 3,crossAxisSpacing: Dimensions.paddingSizeSmall, mainAxisSpacing: Dimensions.paddingSizeSmall):
                  Padding(padding: EdgeInsets.only(top: Get.height/8),
                    child: const Center(child: NoDataFound())):
                   Center(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height/2),
                    child: const CircularProgressIndicator(),
                  )),
                ],),
              );
            }
        ),
        Align(alignment: Alignment.centerRight,child: SizedBox(width: 90, child: CustomButton(onTap: (){}, text: "confirm".tr)))
      ]),
    );
  }
}
