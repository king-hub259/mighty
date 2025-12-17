import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/home/widget/update_branch_and_session_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_home/widget/appbar_header_widget_home_page.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BranchSessionSelectionWidget extends StatelessWidget {
  const BranchSessionSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return GetBuilder<SessionController>(
          builder: (sessionController) {
            String? userType = profileController.profileModel?.data?.role;
            return userType == AppConstants.parent?
            const ParentHeaderSectionWidget():
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: CustomContainer(onTap: ()=> Get.bottomSheet(const UpdateBranchAndSessionWidget()),
                color: Theme.of(context).cardColor.withValues(alpha: .1), verticalPadding: Dimensions.paddingSizeExtraSmall,
                showShadow: false, border: Border.all(color: Theme.of(context).cardColor, width: .5), borderRadius: Dimensions.paddingSizeExtraSmall,
                child: Text("${profileController.currentBranch??'Current Branch..'} | ${sessionController.sessionName ?? "Current Session.."}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            );
          }
        );
      }
    );
  }
}
