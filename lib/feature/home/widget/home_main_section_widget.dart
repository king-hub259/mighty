import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/authentication/logic/authentication_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_home/presentation/parent_web_home_screen.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/presentation/screens/saas_admin_dashboard_summery_widget.dart';
import 'package:mighty_school/feature/report/presentation/screens/web_report_screen.dart';
import 'package:mighty_school/feature/student_module/student_home/presentation/student_web_home_screen.dart';
import 'package:mighty_school/util/app_constants.dart';


class HomeMainSectionWidget extends StatelessWidget {
  final ScrollController scrollController;
  const HomeMainSectionWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (profileController) {
          return GetBuilder<AuthenticationController>(
              builder: (authenticationController) {
                String? userType = profileController.profileModel?.data?.role;
                return Column(children: [

                  Divider(color: Theme.of(context).hintColor, height: 1, thickness: .25),

                  if(userType == AppConstants.parent)...[
                    const ParentWebHomeScreen()
                  ]else if(userType == AppConstants.studentType)...[
                    const StudentWebHomeScreen()
                  ]
                  else...[
                    (profileController.hasPermission("master_configuration.institutes"))?
                    SaasAdminDashboardSummeryWidget(scrollController: scrollController,):
                    WebReportScreen(scrollController: scrollController),
                  ],
                ]);
              }
          );
        }
    );
  }
}
