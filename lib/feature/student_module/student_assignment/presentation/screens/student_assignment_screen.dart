
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/widgets/assignment_item_widget.dart';
import 'package:mighty_school/feature/student_module/student_assignment/controller/student_assignment_controller.dart';
import 'package:mighty_school/feature/student_module/student_assignment/presentation/widgets/student_assignment_item_widget.dart';


class StudentAssignmentScreen extends StatefulWidget {
  const StudentAssignmentScreen({super.key});

  @override
  State<StudentAssignmentScreen> createState() => _StudentAssignmentScreenState();
}

class _StudentAssignmentScreenState extends State<StudentAssignmentScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<StudentAssignmentController>().getMyAssignmentList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "assignment".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: GetBuilder<StudentAssignmentController>(
            builder: (assignmentController) {
              var assignment = assignmentController.assignmentModel?.data;
              return Column(children: [
                assignmentController.assignmentModel != null? (assignmentController.assignmentModel!.data!= null && assignmentController.assignmentModel!.data!.data!.isNotEmpty)?
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
                          return StudentAssignmentItemWidget(index: index,
                            assignmentItem: assignment?.data?[index],);
                        })):

                Padding(padding: EdgeInsets.only(top: Get.height/3),
                  child: const Center(child: NoDataFound())):
                Padding(padding: EdgeInsets.only(top: Get.height / 3), child: const CircularProgressIndicator()),
              ],);
            }
        ),)
      ],),
    );
  }
}



