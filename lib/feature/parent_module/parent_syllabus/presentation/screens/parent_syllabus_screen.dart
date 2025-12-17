
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/parent_module/parent_syllabus/controller/parent_syllabus_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_syllabus/presentation/widgets/parent_syllabus_item_widget.dart';

class ParentSyllabusScreen extends StatefulWidget {
  const ParentSyllabusScreen({super.key});

  @override
  State<ParentSyllabusScreen> createState() => _ParentSyllabusScreenState();
}

class _ParentSyllabusScreenState extends State<ParentSyllabusScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<ParentSyllabusController>().getSyllabusList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "syllabus".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: GetBuilder<ParentSyllabusController>(
            builder: (syllabusController) {
              var syllabus = syllabusController.syllabusModel?.data;
              return Column(children: [
                syllabusController.syllabusModel != null? (syllabusController.syllabusModel!.data!= null && syllabusController.syllabusModel!.data!.isNotEmpty)?
                ListView.builder(
                    itemCount: syllabus?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return ParentSyllabusItemWidget(index: index, syllabusItem: syllabus?[index],);
                    }):
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



