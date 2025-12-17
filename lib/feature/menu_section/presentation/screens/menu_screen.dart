import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/theme_controller.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/authentication/logic/authentication_controller.dart';
import 'package:mighty_school/feature/authentication/presentation/screen/login_screen.dart';
import 'package:mighty_school/feature/authentication/presentation/screen/password_change_screen.dart';
import 'package:mighty_school/feature/language/presentation/screens/select_language_bottom_sheet.dart';
import 'package:mighty_school/feature/menu_section/presentation/widgets/menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/presentation/widgets/profile_info_widget.dart';
import 'package:mighty_school/feature/profile/domain/model/profile_model.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';





class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    if(Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getProfileInfo();
    }
    super.initState();
  }
  bool darkMode = Get.find<ThemeController>().darkTheme;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "profile".tr),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child: GetBuilder<ProfileController>(builder: (profileController) {
                ProfileModel? profileModel  =  profileController.profileModel;
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  ProfileInfoWidget(profileModel: profileModel),


                  Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,0),
                      child: Text("general".tr, style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color))),


                  TitleButton(icon: Images.lock, title: 'change_pin', onTap: ()=> Get.to(()=> const PasswordChangeScreen()),),

                  TitleButton(icon: Images.globe, title: 'app_language', onTap: (){
                    showModalBottomSheet(backgroundColor: Colors.transparent,
                        isScrollControlled: true, context: context, builder: (_)=> const SelectLanguageBottomSheet());
                  },),



                  Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,0),
                      child: Text("others".tr, style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color))),


                  TitleButton(icon: Images.logout, title: 'logout', onTap: (){
                    Get.find<AuthenticationController>().clearSharedData();
                    Get.offAll(()=> const LoginScreen());
                  },),




                  Align(alignment: Alignment.bottomCenter,
                      child: Padding(padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text("${AppConstants.appName} ${"version".tr} : ${AppConstants.version}",
                              style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall)))),

                ],);
              }
          ))
        ],));
  }
}
