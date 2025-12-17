import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_event/controller/parent_event_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_event/presentation/widgets/parent__event_item_widget.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ParentEventListWidget extends  StatelessWidget {
  final ScrollController scrollController;
  const ParentEventListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentEventController>(
      initState: (val){
        Get.find<ParentEventController>().getEventList(1);
      },
        builder: (eventController) {
          var event = eventController.eventModel?.data;
          return Column(spacing: Dimensions.paddingSizeDefault, children: [


            eventController.eventModel != null? (eventController.eventModel!.data!= null && eventController.eventModel!.data!.data!.isNotEmpty)?
            PaginatedListWidget(scrollController: scrollController,
                onPaginate: (int? offset) async {
                  await eventController.getEventList(offset??1);
                }, totalSize: event?.total??0,
                offset: event?.currentPage??0,
                itemView: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: ListView.builder(
                      itemCount: event?.data?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return ParentEventItemWidget(index: index, eventItem: event?.data?[index],);
                      }),
                )):
            Padding(padding: ThemeShadow.getPadding(),
              child: const Center(child: NoDataFound()),
            ):
            Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator()),
          ],);
        }
    );
  }
}
