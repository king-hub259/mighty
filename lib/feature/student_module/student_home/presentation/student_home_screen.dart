import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/parent_module/children/controller/children_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/logic/parent_class_routine_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_home/widget/appbar_header_widget_home_page.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_fees_overview_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:mighty_school/feature/parent_module/parents/presentation/widget/dashboard_summary.dart';
import 'package:mighty_school/feature/student_module/student_class_routine/logic/student_class_routine_controller.dart';
import 'package:mighty_school/feature/student_module/student_profile/logic/student_profile_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';


class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});
  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}


class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  void initState() {
    Get.find<StudentProfileController>().getStudentProfileInfo();
    // Get.find<ParentProfileController>().getDashboardData();
    // Get.find<ChildrenController>().getChildrenList();
    Get.find<StudentClassRoutineController>().getClassRoutineList();
    Get.find<ParentPaidInfoController>().getPaidFeeInfoList();
    Get.find<ParentPaidInfoController>().getUnPaidReport();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {FocusScope.of(context).unfocus();});
    return Scaffold(
      appBar: CustomAppBar(showBakButton: false,
          centerTitle: false,
          titleWidget: Image.asset(Images.logoWithName, height: 30, color: Colors.white,),
          actions: const [Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: ParentHeaderSectionWidget())]),
      body:  CustomWebScrollView(
        slivers:  [


          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(top:Dimensions.paddingSizeDefault,left: Dimensions.paddingSize, right: Dimensions.paddingSize),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
                Text("welcome_back".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
                Text("here_a_quick".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),),

                const DashboardSummarySection(),

                const ParentFeesOverviewWidget(),
                const SizedBox(height: Dimensions.paddingSizeTiny)


              ])))
        ],),
    );
  }
}


