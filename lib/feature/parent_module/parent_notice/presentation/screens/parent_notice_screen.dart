
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_notice/controller/parent_notice_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_notice/presentation/widgets/parent_notice_item_widget.dart';


class ParentNoticeScreen extends StatefulWidget {
  const ParentNoticeScreen({super.key});

  @override
  State<ParentNoticeScreen> createState() => _ParentNoticeScreenState();
}

class _ParentNoticeScreenState extends State<ParentNoticeScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<ParentNoticeController>().getNoticeList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "notice".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: GetBuilder<ParentNoticeController>(
            builder: (noticeController) {
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
                            return ParentNoticeItemWidget(index: index, noticeItem: notice?.data?[index],);
                          }),
                    )):
                Padding(padding: EdgeInsets.only(top: Get.height/4),
                  child: const Center(child: NoDataFound()),
                ):
                Padding(padding: EdgeInsets.only(top: Get.height / 4), child: const CircularProgressIndicator()),
              ],);
            }
        ),)
      ],),
    );
  }
}



