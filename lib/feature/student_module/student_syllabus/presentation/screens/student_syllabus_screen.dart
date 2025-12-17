
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/student_module/student_syllabus/controller/student_syllabus_controller.dart';
import 'package:mighty_school/feature/student_module/student_syllabus/presentation/widgets/student_syllabus_item_widget.dart';
import 'package:mighty_school/util/styles.dart';


class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Get.find<StudentSyllabusController>().getSyllabusList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "syllabus".tr),
      body: CustomScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: GetBuilder<StudentSyllabusController>(builder: (syllabusController) {
              var syllabus = syllabusController.syllabusModel?.data;
              return Column(children: [
                syllabusController.syllabusModel != null? (syllabusController.syllabusModel!.data!= null && syllabusController.syllabusModel!.data!.isNotEmpty)?
                ListView.builder(
                    itemCount: syllabus?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return StudentSyllabusItemWidget(index: index, syllabusItem: syllabus?[index],);
                    }):
                Padding(padding: ThemeShadow.getPadding(), child: const Center(child: NoDataFound())):
                Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator()),
              ],);
            }
        ),)
      ],),
    );
  }
}



