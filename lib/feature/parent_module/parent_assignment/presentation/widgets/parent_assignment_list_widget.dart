
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/controller/parent_assignment_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/presentation/widgets/parent_assignment_item_widget.dart';
import 'package:mighty_school/util/styles.dart';


class ParentAssignmentListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ParentAssignmentListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentAssignmentController>(
      initState: (val)=> Get.find<ParentAssignmentController>().getMyAssignmentList(1),
        builder: (assignmentController) {
          var assignment = assignmentController.assignmentModel?.data;
          return assignmentController.assignmentModel != null? (assignmentController.assignmentModel!.data!= null && assignmentController.assignmentModel!.data!.data!.isNotEmpty)?
          PaginatedListWidget(scrollController: scrollController,
              onPaginate: (int? offset){
                assignmentController.getMyAssignmentList(offset??1);
              }, totalSize: assignment?.total??0,
              offset: assignment?.currentPage??0,
              itemView: ListView.builder(
                  itemCount: assignment?.data?.length??0,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return ParentAssignmentItemWidget(index: index,
                      assignmentItem: assignment?.data?[index],);
                  })):

          Padding(padding: ThemeShadow.getPadding(), child: const Center(child: NoDataFound())):
          Padding(padding: ThemeShadow.getPadding(), child: const Center(child: CircularProgressIndicator()));
        }
    );
  }
}
