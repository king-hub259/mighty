import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/presentation/widgets/parent_routine_list_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_fees_overview_widget.dart';
import 'package:mighty_school/feature/parent_module/parents/presentation/widget/dashboard_summary.dart';
import 'package:mighty_school/feature/student_module/student_profile/domain/model/student_profile_model.dart';
import 'package:mighty_school/feature/student_module/student_profile/logic/student_profile_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentWebHomeScreen extends StatefulWidget {
  const StudentWebHomeScreen({super.key});

  @override
  State<StudentWebHomeScreen> createState() => _StudentWebHomeScreenState();
}

class _StudentWebHomeScreenState extends State<StudentWebHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentProfileController>(
      initState: (val){
        // if(Get.find<ParentProfileController>().dashboardDataModel == null) {
        //   Get.find<ParentProfileController>().getDashboardData();
        // }
        //
        // if(Get.find<ParentClassRoutineController>().classRoutineModel == null){
        //   Get.find<ParentClassRoutineController>().getClassRoutineList();
        // }
        // if(Get.find<ParentPaidInfoController>().paidReportModel == null){
        //   Get.find<ParentPaidInfoController>().getPaidFeeInfoList();
        // }if(Get.find<ParentPaidInfoController>().unPaidReportModel == null){
        //   Get.find<ParentPaidInfoController>().getUnPaidReport();
        // }
      },
      builder: (profileController) {
       StudentProfileModel ? profileModel = profileController.profileModel;
        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${"welcome_back".tr} ${profileModel?.data?.name??'N/A'}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
            Text("here_a_quick".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),),

            const SizedBox(height: Dimensions.paddingSizeDefault),
            const DashboardSummarySection(),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            const ParentFeesOverviewWidget(),

            const SizedBox(height: Dimensions.paddingSizeDefault),
            const ParentRoutineListWidget(),


          ]),
        );
      }
    );
  }
}
