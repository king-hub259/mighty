
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/student_module/student_notice/controller/student_notice_controller.dart';
import 'package:mighty_school/feature/student_module/student_notice/presentation/widgets/student_notice_item_widget.dart';
import 'package:mighty_school/util/styles.dart';

class StudentNoticeScreen extends StatefulWidget {
  const StudentNoticeScreen({super.key});
  @override
  State<StudentNoticeScreen> createState() => _StudentNoticeScreenState();
}

class _StudentNoticeScreenState extends State<StudentNoticeScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Get.find<StudentNoticeController>().getNoticeList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "notice".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: GetBuilder<StudentNoticeController>(builder: (noticeController) {
              var notice = noticeController.noticeModel?.data;
              return Column(children: [
                noticeController.noticeModel != null? (noticeController.noticeModel!.data!= null && noticeController.noticeModel!.data!.data!.isNotEmpty)?
                PaginatedListWidget(scrollController: scrollController,
                    onPaginate: (int? offset){
                      noticeController.getNoticeList(offset??1);
                    }, totalSize: notice?.total??0,
                    offset: notice?.currentPage??0,
                    itemView: Padding(
                      padding: const EdgeInsets.only(bottom: 80.0),
                      child: ListView.builder(
                          itemCount: notice?.data?.length??0,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return StudentNoticeItemWidget(index: index, noticeItem: notice?.data?[index],);
                          }),
                    )):
                Padding(padding:ThemeShadow.getPadding(), child: const Center(child: NoDataFound())):
                Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator()),
              ],);
            }
        ),)
      ],),
    );
  }
}



