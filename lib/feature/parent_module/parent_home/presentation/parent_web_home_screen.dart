import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/parent_module/children/controller/children_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/logic/parent_class_routine_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/presentation/widgets/parent_routine_list_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/presentation/widgets/parent_fees_overview_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/domain/model/parent_profile_model.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:mighty_school/feature/parent_module/parents/presentation/widget/dashboard_summary.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ParentWebHomeScreen extends StatefulWidget {
  const ParentWebHomeScreen({super.key});

  @override
  State<ParentWebHomeScreen> createState() => _ParentWebHomeScreenState();
}

class _ParentWebHomeScreenState extends State<ParentWebHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentProfileController>(
      initState: (val){
        if(Get.find<ParentProfileController>().dashboardDataModel == null) {
          Get.find<ParentProfileController>().getDashboardData();
        }
        if(Get.find<ChildrenController>().childrenModel == null){
          Get.find<ChildrenController>().getChildrenList();
        }
        if(Get.find<ParentClassRoutineController>().classRoutineModel == null){
          Get.find<ParentClassRoutineController>().getClassRoutineList();
        }
        if(Get.find<ParentPaidInfoController>().paidReportModel == null){
          Get.find<ParentPaidInfoController>().getPaidFeeInfoList();
        }if(Get.find<ParentPaidInfoController>().unPaidReportModel == null){
          Get.find<ParentPaidInfoController>().getUnPaidReport();
        }
      },
      builder: (profileController) {
        ParentProfileModel ? profileModel = profileController.profileModel;
        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${"welcome_back".tr} ${profileModel?.data?.parentName??'N/A'}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
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
