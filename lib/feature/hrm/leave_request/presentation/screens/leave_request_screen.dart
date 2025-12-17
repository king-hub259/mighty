
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/hrm/leave_request/controller/leave_request_controller.dart';
import 'package:mighty_school/feature/hrm/leave_request/presentation/screens/create_new_leave_request_screen.dart';
import 'package:mighty_school/feature/hrm/leave_request/presentation/widgets/leave_request_item_widget.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<LeaveRequestController>().getLeaveRequestList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "leave_request_list".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: GetBuilder<LeaveRequestController>(
            builder: (leaveRequestController) {
              var leaveRequest = leaveRequestController.leaveModel?.data;
              return  leaveRequestController.leaveModel != null? (leaveRequestController.leaveModel!.data!= null && leaveRequestController.leaveModel!.data!.data!.isNotEmpty)?
              Column(children: [
                PaginatedListWidget(scrollController: scrollController,
                    onPaginate: (int? offset){
                      leaveRequestController.getLeaveRequestList(offset??1);
                    }, totalSize: leaveRequest?.total??0,
                    offset: leaveRequest?.currentPage??0,
                    itemView: ListView.builder(
                        itemCount: leaveRequest?.data?.length??0,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return LeaveRequestItemWidget(index: index,
                            leaveItem: leaveRequest?.data?[index],);
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
        Get.to(()=> const CreateNewLeaveRequestScreen());
      },
        label: Row(children: [
          const Icon(Icons.add), Text("add_new_leave_request".tr)
        ],),),
    );
  }
}



