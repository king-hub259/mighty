import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/landing_page/domain/models/why_choose_us_model.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/management_title.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';



class WhyChooseUsWidget extends StatelessWidget {
  const WhyChooseUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      builder: (landingPageController) {

        return  Center(
          child: SizedBox(width: Dimensions.webMaxWidth,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("${"why".tr} ${AppConstants.appName}?",style: textSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 20),),
                SizedBox(width: 800, child: Text("revolutionizing_school_management".tr,
                  style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeExtraOverLarge),textAlign: TextAlign.center,)),

                SizedBox(width: 850,
                  child: Text("${AppConstants.appName} ${"school_is_design_ro_simplify".tr}",
                    style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),textAlign: TextAlign.center,),),
                 SizedBox(height: Dimensions.landingPagePadding),
                 ResponsiveHelper.isDesktop(context)?
                 const Row(spacing: Dimensions.paddingSizeLarge, children: [
                    Expanded(
                      child: Column(spacing: 40, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          ManagementTile(title: "Effortless Automation", description: "Reduce manual work with smart automation.",image: Images.automation,),
                          ManagementTile(title: "Seamless Communication",description: "Keep students, teachers, and parents connected.",image: Images.communication,),
                          ManagementTile(title: "Data-Driven Insights",description: "AI-powered analytics for better decision-making.",image: Images.insights,),
                          ManagementTile(title: "100% Cloud-Based",description: "Access anytime, anywhere with secure data storage.",image: Images.cloud,),
                          ManagementTile(title: "Scalable & Customizable",description: "Designed for schools of all sizes.",image: Images.scalable,),
                        ],
                      ),
                    ),
                    Expanded(child: CustomImage(placeholder: Images.whyChooseUs, height: 480, width: 608,))
                  ],
                ): Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Column( children: [
                     Column(spacing: Dimensions.landingPagePadding, crossAxisAlignment: CrossAxisAlignment.start, children: const [
                       ManagementTile(title: "Effortless Automation", description: "Reduce manual work with smart automation.",image: Images.automation,),
                       ManagementTile(title: "Seamless Communication",description: "Keep students, teachers, and parents connected.",image: Images.communication,),
                       ManagementTile(title: "Data-Driven Insights",description: "AI-powered analytics for better decision-making.",image: Images.insights,),
                       ManagementTile(title: "100% Cloud-Based",description: "Access anytime, anywhere with secure data storage.",image: Images.cloud,),
                       ManagementTile(title: "Scalable & Customizable",description: "Designed for schools of all sizes.",image: Images.scalable,),
                     ],
                     ),
                     const CustomImage(placeholder: Images.whyChooseUs, height: 480, width: 608,)
                   ],
                   ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

class WhyChooseUsItemWidget extends StatelessWidget {
  final WhyChooseUsItem? item;
  const WhyChooseUsItemWidget({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SvgPicture.asset(Images.logo),
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          CustomImage(image: item?.icon, height: 80,),
          const SizedBox(height: 35,),
          Text("${item?.title}", style: textBold.copyWith(fontSize: 20, color: Theme.of(context).colorScheme.primary),),
          Text("${item?.description}",maxLines: 3,overflow: TextOverflow.ellipsis,
            style: textRegular.copyWith(color: Theme.of(context).hintColor),textAlign: TextAlign.center,),

        ],
      ),
    ]);
  }
}
