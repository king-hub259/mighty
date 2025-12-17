
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/controller/parent_assignment_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/domain/models/submited_assignment_model.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/presentation/widgets/submitted_assignment_item_widget.dart';
import 'package:mighty_school/util/styles.dart';

class SubmittedAssignmentListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SubmittedAssignmentListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentAssignmentController>(
      initState: (val)=> Get.find<ParentAssignmentController>().getSubmittedAssignmentList(1),
        builder: (assignmentController) {
        SubmittedAssignmentModel? assignmentModel = assignmentController.submittedAssignmentModel;
          var assignment = assignmentModel?.data;
          return assignmentModel != null? (assignment != null && assignment.data!.isNotEmpty)?
          PaginatedListWidget(scrollController: scrollController,
              onPaginate: (int? offset) async {
                await assignmentController.getMyAssignmentList(offset??1);
              }, totalSize: assignment.total??0,
              offset: assignment.currentPage??0,
              itemView: ListView.builder(
                  itemCount: assignment.data?.length??0,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return SubmittedAssignmentItemWidget(index: index, assignmentItem: assignment.data?[index]);
                  })):

          Padding(padding: ThemeShadow.getPadding(), child: const Center(child: NoDataFound())):
          Padding(padding: ThemeShadow.getPadding(), child: const Center(child: CircularProgressIndicator()));
        }
    );
  }
}
