import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/presentation/widgets/attendance_fine_summery_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/domain/model/parent_dashboard_data_model.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:mighty_school/feature/parent_module/parents/presentation/widget/student_card_widget.dart';
import 'package:mighty_school/feature/parent_module/parents/presentation/widget/task_summery_card_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';


class DashboardSummarySection extends StatelessWidget {
  const DashboardSummarySection({super.key,});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ParentProfileController>(
      builder: (profileController) {
        ParentDashboardDataModel? dashboardDataModel = profileController.dashboardDataModel;
        return ResponsiveHelper.isDesktop(context)?
        Column(spacing: Dimensions.paddingSizeDefault, children: [
          Row(spacing: Dimensions.paddingSizeDefault,
            children: [
              const Expanded(flex: 2,child: StudentCardWidget()),
              Expanded(flex: 3,child: Column(spacing: Dimensions.paddingSizeDefault, children: [
                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: TaskSummeryCardWidget(
                    value: "${(dashboardDataModel?.data?.attendance?.overallPercentage ?? 0).toStringAsFixed(2)}%",
                    color: Theme.of(context).primaryColorDark, title: 'total_attendance'.tr,)),
                  Expanded(child: TaskSummeryCardWidget(value: "${(dashboardDataModel?.data?.attendance?.monthlyPercentage ?? 0).toStringAsFixed(2)}%",
                      color: Theme.of(context).primaryColor, title: 'monthly_attendance'.tr))]),


                Row(spacing: Dimensions.paddingSizeDefault,children: [
                  Expanded(child: TaskSummeryCardWidget(value: "${(dashboardDataModel?.data?.tasks ?? 0).toString().padLeft(2, '0')} ${"tasks".tr}",
                    color: Theme.of(context).colorScheme.secondaryFixed, title: 'pending_homework'.tr,)),
                  Expanded(child: TaskSummeryCardWidget(value:  (dashboardDataModel?.data?.upcomingExams ?? 0).toString().padLeft(2, '0'),
                    color: Theme.of(context).colorScheme.secondaryContainer, title: 'upcoming_exams'.tr,))
                ]),
              ],))
            ],
          ),
          const AttendanceFineSummeryWidget(),


        ],):
        Column(spacing: Dimensions.paddingSizeDefault, children: [
          const StudentCardWidget(),
          const AttendanceFineSummeryWidget(),

          Row(spacing: Dimensions.paddingSizeDefault, children: [
              Expanded(child: TaskSummeryCardWidget(
                value: "${(dashboardDataModel?.data?.attendance?.overallPercentage ?? 0).toStringAsFixed(2)}%",
                color: Theme.of(context).primaryColorDark, title: 'total_attendance'.tr,)),
              Expanded(child: TaskSummeryCardWidget(value: "${(dashboardDataModel?.data?.attendance?.monthlyPercentage ?? 0).toStringAsFixed(2)}%",
                  color: Theme.of(context).primaryColor, title: 'monthly_attendance'.tr))]),


          Row(spacing: Dimensions.paddingSizeDefault,children: [
            Expanded(child: TaskSummeryCardWidget(value: "${(dashboardDataModel?.data?.tasks ?? 0).toString().padLeft(2, '0')} ${"tasks".tr}",
        color: Theme.of(context).colorScheme.secondaryFixed, title: 'pending_homework'.tr,)),
            Expanded(child: TaskSummeryCardWidget(value:  (dashboardDataModel?.data?.upcomingExams ?? 0).toString().padLeft(2, '0'),
              color: Theme.of(context).colorScheme.secondaryContainer, title: 'upcoming_exams'.tr,))
          ]),
        ],);
      }
    );
  }
}


