
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/section_header_with_path_widget.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/presentation/widgets/absent_fine_widget.dart';

class AbsentFineScreen extends StatefulWidget {
  const AbsentFineScreen({super.key});

  @override
  State<AbsentFineScreen> createState() => _AbsentFineScreenState();
}

class _AbsentFineScreenState extends State<AbsentFineScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "absent_fine".tr),
      body: CustomWebScrollView(controller: scrollController, slivers:  [

        SliverToBoxAdapter(child: Column(children: [
          SectionHeaderWithPath(sectionTitle: "student_attendance_information".tr,
              pathItems: ["absent_fine".tr]),
          const AbsentFineWidget()
        ]))
      ],),
    );
  }
}



