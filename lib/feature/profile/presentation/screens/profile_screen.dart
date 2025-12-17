import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/feature/profile/presentation/widgets/password_update_widget.dart';
import 'package:mighty_school/feature/profile/presentation/widgets/profile_information_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    if(Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getProfileInfo();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "profile".tr,),
      body: const CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ProfileInformationWidget(),
              SizedBox(height: Dimensions.paddingSizeDefault),
              PasswordUpdateWidget(),
            SizedBox(height: Dimensions.paddingSizeDefault,)

            ],
          ),
        ),)
      ],),
    );
  }
}
