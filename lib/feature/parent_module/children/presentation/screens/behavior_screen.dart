
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/parent_module/children/controller/children_controller.dart';
import 'package:mighty_school/feature/parent_module/children/domain/model/behavior_model.dart';
import 'package:mighty_school/feature/parent_module/children/presentation/widgets/behaviour_item_widget.dart';

class BehaviourScreen extends StatefulWidget {
  const BehaviourScreen({super.key});

  @override
  State<BehaviourScreen> createState() => _BehaviourScreenState();
}

class _BehaviourScreenState extends State<BehaviourScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<ChildrenController>().getChildrenBehaviors(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "behaviour".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: GetBuilder<ChildrenController>(
            builder: (behaviorController) {
              BehaviorModel? behaviorModel = behaviorController.behaviorsModel;
              var behaviour = behaviorModel?.data;
              return Column(children: [
                behaviorModel != null? (behaviour != null && behaviour.data!.isNotEmpty)?
                PaginatedListWidget(scrollController: scrollController,
                    onPaginate: (int? offset) async {
                      await behaviorController.getChildrenBehaviors(offset??1);
                    }, totalSize: behaviour.total??0,
                    offset: behaviour.currentPage??0,
                    itemView: Padding(
                      padding: const EdgeInsets.only(bottom: 80.0),
                      child: ListView.builder(
                          itemCount: behaviour.data?.length??0,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return BehaviourItemWidget(index: index, behaviorItem: behaviour.data?[index],);
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



