import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/splash_controller.dart';
import 'package:mighty_school/common/widget/text_hover.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/localization/localization_controller.dart';
import 'package:mighty_school/theme/light_theme.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';
import 'package:url_launcher/url_launcher_string.dart';


class FooterView extends StatefulWidget {
  const FooterView({super.key});

  @override
  State<FooterView> createState() => _FooterViewState();
}

class _FooterViewState extends State<FooterView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColorLight;
    return GetBuilder<SplashController>(builder: (splashController){
      return Container(
        color: Theme.of(context).primaryColorDark,
        width: double.maxFinite,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: Dimensions.webMaxWidth,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const SizedBox(height: Dimensions.paddingSizeLarge * 2),
                            Image.asset(Images.logoWithName,width: 180,),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Row(children: [
                                Image.asset(Images.logoWithName,width: 18,),
                                const SizedBox(width: Dimensions.paddingSizeSmall),
                                Text("Dhaka", style: textRegular.copyWith(color: color,fontSize: Dimensions.fontSizeExtraSmall,),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('follow_us_on'.tr, style: textRegular.copyWith(color: color,fontSize: Dimensions.fontSizeExtraSmall)),
                                SizedBox(height: 50,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index){
                                      
                                     return InkWell(
                                        onTap: (){
                                        },
                                        child: Padding(padding: const EdgeInsets.only(right: 15.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                            child: Center(child: Image.asset(Images.logo, height: 15, width: 15, fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );

                                    },
                                    itemCount:  4,),
                                ),
                                const SizedBox(height: 20,)
                              ],
                            )
                          ],
                        )),
                    const SizedBox(width: Dimensions.paddingSizeLarge,),

                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeLarge * 2),
                            Text( 'download_our_app'.tr, style: textRegular.copyWith(color: color,fontSize: Dimensions.fontSizeLarge)),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Text( 'download_our_app_from_google_play_store'.tr, style: textRegular.copyWith(color: color,fontSize: Dimensions.fontSizeExtraSmall)),
                            const SizedBox(height: Dimensions.paddingSizeLarge),
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                  InkWell(onTap:(){
                                    
                                  },child: Image.asset(Images.logo,height: 40,fit: BoxFit.contain)),
                                const SizedBox(width: Dimensions.paddingSizeSmall,),

                                  InkWell(onTap:(){

                                  },child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Image.asset(Images.logo,height: 40,fit: BoxFit.contain),
                                  )),
                              ],)
                          ],
                        ),
                      ),
                    Expanded(flex: 2,child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeLarge * 2),
                        Text('useful_link'.tr, style: textRegular.copyWith(color: color,fontSize: Dimensions.fontSizeLarge)),
                        const SizedBox(height: 5.0,),
                        Container(
                          height: 1,
                          width: 60,
                          color: Theme.of(context).colorScheme.primary,),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        FooterButton(title: 'privacy_policy'.tr, route: RouteHelper.getHtmlRoute('privacy-policy')),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        FooterButton(title: 'terms_and_conditions'.tr, route: RouteHelper.getHtmlRoute('terms-and-condition')),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        FooterButton(title: 'about_us'.tr, route: RouteHelper.getHtmlRoute('about_us')),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        FooterButton(title: 'contact_us'.tr, route: RouteHelper.getSignInRoute()),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                      ],),
                    ),
                    Expanded(flex: 2,child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeLarge * 2),
                        Text('quick_links'.tr, style: textRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeLarge)),
                        const SizedBox(height: 5.0,),
                        Container(
                          height: 1,
                          width: 60,
                          color: Theme.of(context).colorScheme.primary,),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        FooterButton(title: 'current_offers'.tr, route: RouteHelper.getSignInRoute()),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        FooterButton(title: 'popular_services'.tr, route: RouteHelper.getSignInRoute()),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        FooterButton(title: 'categories'.tr, route: RouteHelper.getSignInRoute()),
                        const SizedBox(height: Dimensions.paddingSizeSmall),


                        FooterButton(title: 'become_a_provider'.tr,
                          url: true, route: '${AppConstants.baseUrl}/provider/auth/sign-up',
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                      ],)),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      width: double.maxFinite,
                      color:const Color(0xff253036),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: Center(child: Text(
                          "footer text",
                          style: textRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeSmall),
                        )),
                      )
                  ),
                  Positioned(
                    top: -32,
                    left: Get.find<LocalizationController>().isLtr?(MediaQuery.of(context).size.width-Dimensions.webMaxWidth)/2:0,
                    right: !Get.find<LocalizationController>().isLtr?0:(MediaQuery.of(context).size.width-Dimensions.webMaxWidth)/2,
                    child: Center(
                      child: SizedBox(
                        width: Dimensions.webMaxWidth,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                color: Colors.grey.withValues(alpha: 0.2),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal:Dimensions.paddingSizeDefault,
                                vertical: Dimensions.paddingSizeSmall,
                              ),
                              child: Row(
                                children: [
                                  ContactUsWidget(
                                    title: "email_us".tr,
                                    subtitle: "email@gmail.com",
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeExtraLarge,),
                                  ContactUsWidget(
                                    title: "call_us".tr,
                                    subtitle: "phone12344566",
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                                ],
                              ),
                            ),
                            const Expanded(child: SizedBox())
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

class ContactUsWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const ContactUsWidget({super.key, required this.title, required this.subtitle}) ;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
          color: lightTheme.cardColor.withValues(alpha: 0.8))),
        const SizedBox(height: Dimensions.paddingSizeSmall,),
        Text(subtitle, style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
            color: lightTheme.cardColor.withValues(alpha: 0.6)),
        ),
      ],
    );
  }
}


class FooterButton extends StatelessWidget {
  final String title;
  final String route;
  final bool url;
  const FooterButton({super.key, required this.title, required this.route, this.url = false});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        hoverColor: Colors.transparent,
        onTap: route.isNotEmpty ? () async {
          if(url) {
            if(await canLaunchUrlString(route)) {
              launchUrlString(route, mode: LaunchMode.externalApplication);
            }
          }
        } : null,
        child: Text(title, style: hovered ? textRegular.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontSize: Dimensions.fontSizeExtraSmall)
            : textRegular.copyWith(
            color: Colors.white,
            fontSize: Dimensions.fontSizeExtraSmall)),
      );
    });
  }
}