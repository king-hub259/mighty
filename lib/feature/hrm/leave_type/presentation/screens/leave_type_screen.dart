
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/hrm/leave_type/controller/leave_type_controller.dart';
import 'package:mighty_school/feature/hrm/leave_type/presentation/screens/create_new_leave_type_screen.dart';
import 'package:mighty_school/feature/hrm/leave_type/presentation/widgets/leave_type_item_widget.dart';

class LeaveTypeScreen extends StatefulWidget {
  const LeaveTypeScreen({super.key});

  @override
  State<LeaveTypeScreen> createState() => _LeaveTypeScreenState();
}

class _LeaveTypeScreenState extends State<LeaveTypeScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<LeaveTypeController>().getLeaveTypeList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "leave_type".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: GetBuilder<LeaveTypeController>(
            builder: (leaveTypeController) {
              var leaveType = leaveTypeController.leaveTypeModel?.data;
              return  leaveTypeController.leaveTypeModel != null? (leaveTypeController.leaveTypeModel!.data!= null && leaveTypeController.leaveTypeModel!.data!.data!.isNotEmpty)?
              Column(children: [
                PaginatedListWidget(scrollController: scrollController,
                    onPaginate: (int? offset){
                      leaveTypeController.getLeaveTypeList(offset??1);
                    }, totalSize: leaveType?.total??0,
                    offset: leaveType?.currentPage??0,
                    itemView: ListView.builder(
                        itemCount: leaveType?.data?.length??0,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return LeaveTypeItemWidget(index: index,
                            leaveTypeItem: leaveType?.data?[index],);
                        }))
              ],):
              Padding(padding: EdgeInsets.only(top: Get.height/4),
                child: const Center(child: NoDataFound()),
              ):
              Padding(padding: EdgeInsets.only(top: Get.height / 4), child: const Center(child: CircularProgressIndicator()));
            }
        ),)
      ],),


      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Get.to(()=> const CreateNewLeaveTypeScreen());
      },
        label: Row(children: [
          const Icon(Icons.add), Text("add_new_leave_type".tr)
        ],),),
    );
  }
}



