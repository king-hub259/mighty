import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/routine_management/assignment/controller/assignment_controller.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/widgets/assignment_item_widget.dart';
import 'package:mighty_school/feature/routine_management/assignment/presentation/widgets/create_new_assignment_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class AssignmentListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const AssignmentListWidget({super.key, required this.scrollController});

  @override
  State<AssignmentListWidget> createState() => _AssignmentListWidgetState();
}

class _AssignmentListWidgetState extends State<AssignmentListWidget> {
  @override
  void initState() {
    Get.find<AssignmentController>().getAssignmentList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssignmentController>(
        builder: (assignmentController) {
          var assignment = assignmentController.assignmentModel?.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(children: [

              if(ResponsiveHelper.isDesktop(context))
                CustomTitle(title: "assignment_list", widget: SizedBox(width: 120, child: CustomButton(onTap: (){
                 Get.bottomSheet(isScrollControlled: true, const CustomContainer(child: CreateNewAssignmentWidget()));
                }, text: "add".tr)),),


              assignmentController.assignmentModel != null? (assignmentController.assignmentModel!.data!= null && assignmentController.assignmentModel!.data!.data!.isNotEmpty)?
              PaginatedListWidget(scrollController: widget.scrollController,
                  onPaginate: (int? offset){
                    assignmentController.getAssignmentList(offset??1);
                  }, totalSize: assignment?.total??0,
                  offset: assignment?.currentPage??0,
                  itemView: ListView.builder(
                      itemCount: assignment?.data?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return AssignmentItemWidget(index: index,
                          assignmentItem: assignment?.data?[index],);
                      })):
              Padding(padding: EdgeInsets.only(top: Get.height/4),
                child: const Center(child: NoDataFound()),
              ):
              Padding(padding: EdgeInsets.only(top: Get.height / 4), child: const CircularProgressIndicator()),
            ],),
          );
        }
    );
  }
}
