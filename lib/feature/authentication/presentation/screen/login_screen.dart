import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/authentication/logic/authentication_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    if(AppConstants.demo){
      userNameController.text = "saasadmin@gmail.com";
      passwordController.text = "12345678";
    }
    if(Get.find<AuthenticationController>().isLoggedIn()){
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed(RouteHelper.getDashboardRoute());
      });
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(children: [
          GetBuilder<AuthenticationController>(
              builder: (authenticationController) {
                return Center(
                  child: CustomContainer(width: ResponsiveHelper.isDesktop(context)? 900 : Get.width,
                    horizontalPadding: 0,verticalPadding: 0,borderRadius: 0,
                    color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent,
                    showShadow: ResponsiveHelper.isDesktop(context),
                    child: Row(children: [
                        if(ResponsiveHelper.isDesktop(context))
                          Expanded(child:  Stack(children: [
                              Image.asset(Images.loginImage, height: 700),
                              Positioned(left: 0, right: 8, bottom: 0,
                                child: Container(height: 200,decoration:  const BoxDecoration(
                                    gradient: LinearGradient(colors: [Colors.transparent, Colors.black],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.0, 1.0],)))
                              ),
                              Positioned(left: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeDefault,
                                child: SizedBox(width: 400,
                                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                    child: Column(spacing: Dimensions.paddingSizeSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(AppConstants.slogan, style: textHeavy.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Colors.white)),
                                      Text("${"managing_your_school_effortlessly".tr} ${AppConstants.appName}",
                                        style: textRegular.copyWith(color: Colors.white)),
                                    ]),
                                  ),
                                ),
                              ),

                            ],
                          )),
                        SizedBox(width: ResponsiveHelper.isDesktop(context)? 400 : Get.width,
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Image.asset(Images.logoWithName, height: 40),
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                            Text("access_your_mighty_school_dashboard".tr, style: textMedium.copyWith()),
                            const SizedBox(height: Dimensions.paddingSizeLarge),

                            Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                CustomTextField(
                                  controller: userNameController,
                                  title: "email_address".tr,hintText: "email_address".tr,
                                  filled: true, showBorder: false,
                                  prefixIcon: Images.mailIconSvg,
                                  prefixIconColor: Theme.of(context).hintColor,
                                  prefixIconSize: 16,
                                  fillColor: Theme.of(context).hintColor.withValues(alpha: 0.1),
                                ),

                                const SizedBox(height: Dimensions.paddingSize,),
                                CustomTextField(
                                  controller: passwordController,
                                  title: "password".tr,hintText: "password".tr,
                                  filled: true, showBorder: false,
                                  isPassword: true,
                                  prefixIcon: Images.lockIconSvg,
                                  prefixIconSize: 20,
                                  prefixIconColor: Theme.of(context).hintColor,
                                  fillColor: Theme.of(context).hintColor.withValues(alpha: 0.1),
                                ),

                                const SizedBox(height: Dimensions.paddingSizeLarge,),
                                Row(children: [
                                  Checkbox(value: authenticationController.isActiveRememberMe,
                                      onChanged: (value) {
                                        authenticationController.toggleRememberMe();
                                      },
                                      activeColor: Theme.of(context).colorScheme.secondary, checkColor: Theme.of(context).cardColor,
                                      side: BorderSide(color: Theme.of(context).hintColor, width: 2)),

                                  Expanded(child: Text("remember_me".tr, style: textMedium.copyWith(color: Theme.of(context).hintColor),)),
                                  TextButton(onPressed: (){},
                                      child: Text("forget_password".tr, style: textRegular.copyWith(color: Theme.of(context).colorScheme.secondary),))

                                ]),

                                const SizedBox(height: 20,),
                                authenticationController.isLoading? const Center(child: CircularProgressIndicator()):
                                CustomButton(onTap: () {
                                  String username = userNameController.text.trim();
                                  String password = passwordController.text.trim();
                                  if(username.isEmpty){
                                    showCustomSnackBar("username_is_empty".tr);
                                  }else if(!username.isEmail){
                                    showCustomSnackBar("username_is_invalid".tr);
                                  }
                                  else if(password.isEmpty){
                                    showCustomSnackBar("password_is_empty".tr);
                                  }
                                  else{
                                    if(authenticationController.isActiveRememberMe){
                                      authenticationController.saveEmailAndPassword(username, password);
                                    }
                                    authenticationController.login(username, password);
                                  }
                                }, text: "login".tr,height: 45),

                                const SizedBox(height: Dimensions.paddingSizeSmall),
                                if(AppConstants.demo)...[
                                Row(spacing: Dimensions.paddingSizeExtraSmall,
                                    children: [
                                  Expanded(child: CustomButton(onTap: (){
                                    authenticationController.setSelectedIndex(0);
                                    userNameController.text = "saasadmin@gmail.com";
                                    passwordController.text = "12345678";
                                    authenticationController.setUserType("saasAdmin");
                                  }, text: "saas_admin".tr, showBorderOnly: authenticationController.selectedIndex != 0,
                                      borderColor: Theme.of(context).primaryColor.withValues(alpha: .125),
                                      textColor: authenticationController.selectedIndex == 0? Colors.white: Theme.of(context).textTheme.displayLarge!.color!,
                                      buttonColor: authenticationController.selectedIndex == 0? Theme.of(context).primaryColor: Colors.transparent)),
                                  Expanded(child: CustomButton(onTap: (){
                                    authenticationController.setSelectedIndex(1);
                                    userNameController.text = "superadmin@gmail.com";
                                    passwordController.text = "12345678";
                                    authenticationController.setUserType("seperAdmin");
                                  }, text: "super_admin".tr,
                                      showBorderOnly: authenticationController.selectedIndex != 1,
                                      borderColor: Theme.of(context).primaryColor.withValues(alpha: .125),
                                      textColor: authenticationController.selectedIndex == 1? Colors.white: Theme.of(context).textTheme.displayLarge!.color!,
                                      buttonColor: authenticationController.selectedIndex == 1? Theme.of(context).primaryColor: Colors.transparent
                                  )),
                                  Expanded(child: CustomButton(onTap: (){
                                    authenticationController.setSelectedIndex(2);
                                    userNameController.text = "systemadmin@gmail.com";
                                    passwordController.text = "12345678";
                                    authenticationController.setUserType("systemAdmin");
                                  }, text: "system_admin".tr,
                                      showBorderOnly: authenticationController.selectedIndex != 2,
                                      borderColor: Theme.of(context).primaryColor.withValues(alpha: .125),
                                      textColor: authenticationController.selectedIndex == 2? Colors.white: Theme.of(context).textTheme.displayLarge!.color!,
                                      buttonColor: authenticationController.selectedIndex == 2? Theme.of(context).primaryColor: Colors.transparent
                                  )),
                                ]),
                                const SizedBox(height: Dimensions.paddingSizeSmall),
                                Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
                                  Expanded(child: CustomButton(onTap: (){
                                    authenticationController.setSelectedIndex(3);
                                    userNameController.text = "librarian@gmail.com";
                                    passwordController.text = "12345678";
                                    authenticationController.setUserType("librarian");
                                  }, text: "librarian".tr,
                                      showBorderOnly: authenticationController.selectedIndex != 3,
                                      borderColor: Theme.of(context).primaryColor.withValues(alpha: .125),
                                      textColor: authenticationController.selectedIndex == 3? Colors.white: Theme.of(context).textTheme.displayLarge!.color!,
                                      buttonColor: authenticationController.selectedIndex == 3? Theme.of(context).primaryColor: Colors.transparent
                                  )),
                                  Expanded(child: CustomButton(onTap: (){
                                    authenticationController.setSelectedIndex(4);
                                    userNameController.text = "accountant@gmail.com";
                                    passwordController.text = "12345678";
                                    authenticationController.setUserType("accounting");
                                  }, text: "accounting".tr,
                                      showBorderOnly: authenticationController.selectedIndex != 4,
                                      borderColor: Theme.of(context).primaryColor.withValues(alpha: .125),
                                      textColor: authenticationController.selectedIndex == 4? Colors.white: Theme.of(context).textTheme.displayLarge!.color!,
                                      buttonColor: authenticationController.selectedIndex == 4? Theme.of(context).primaryColor: Colors.transparent
                                  )),
                                  Expanded(child: CustomButton(onTap: (){
                                    authenticationController.setSelectedIndex(5);
                                    userNameController.text = "teacher@gmail.com";
                                    passwordController.text = "12345678";
                                    authenticationController.setUserType("teacher");
                                  }, text: "teacher".tr,
                                      showBorderOnly: authenticationController.selectedIndex != 5,
                                      borderColor: Theme.of(context).primaryColor.withValues(alpha: .125),
                                      textColor: authenticationController.selectedIndex == 5? Colors.white: Theme.of(context).textTheme.displayLarge!.color!,
                                      buttonColor: authenticationController.selectedIndex == 5? Theme.of(context).primaryColor: Colors.transparent
                                  )),
                                ]),
                                  const SizedBox(height: Dimensions.paddingSizeSmall),

                                  Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
                                    Expanded(child: CustomButton(onTap: (){
                                      authenticationController.setSelectedIndex(6);
                                      userNameController.text = "parent@gmail.com";
                                      passwordController.text = "12345678";
                                      authenticationController.setUserType("parent");
                                    }, text: "login_as_a_parents".tr,
                                        showBorderOnly: authenticationController.selectedIndex != 6,
                                        borderColor: Theme.of(context).primaryColor.withValues(alpha: .125),
                                        textColor: authenticationController.selectedIndex == 6? Colors.white: Theme.of(context).textTheme.displayLarge!.color!,
                                        buttonColor: authenticationController.selectedIndex == 6? Theme.of(context).primaryColor: Colors.transparent
                                    )),
                                    Expanded(child: CustomButton(onTap: (){
                                      authenticationController.setSelectedIndex(7);
                                      userNameController.text = "student@gmail.com";
                                      passwordController.text = "12345678";
                                      authenticationController.setUserType("student");
                                    }, text: "login_as_a_student".tr,
                                        showBorderOnly: authenticationController.selectedIndex != 7,
                                        borderColor: Theme.of(context).primaryColor.withValues(alpha: .125),
                                        textColor: authenticationController.selectedIndex == 7? Colors.white: Theme.of(context).textTheme.displayLarge!.color!,
                                        buttonColor: authenticationController.selectedIndex == 7? Theme.of(context).primaryColor: Colors.transparent
                                    )),

                                  ]),


                                ],

                              ],),
                            ),

                          ]),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
          Positioned(bottom: 10, right: 10, child: Text("${"app_version".tr}:- ${AppConstants.version}:${AppConstants.versionCode}",
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),))
        ],
      )
    );
  }
}
