import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/daliverable_card_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class DeliverableSection extends StatelessWidget {
  const DeliverableSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      builder: (landingPageController) {
        return Center(
          child: SizedBox(width: Dimensions.webMaxWidth,
            child: Column(spacing: Dimensions.paddingSizeDefault, children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.isDesktop(context)? 0: Dimensions.paddingSizeDefault),
                  child: Text("${"what_included_with".tr} ${AppConstants.appName}?", textAlign: TextAlign.center,
                      style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeExtraOverLarge))),
                Padding(padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.isDesktop(context)? 0: Dimensions.paddingSizeDefault),
                  child: Text("what_includes".tr,
                    style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),textAlign: TextAlign.center,),
                ),

                Center(child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomContainer(height: 60,verticalPadding: 8,
                        color: Theme.of(context).primaryColor.withValues(alpha: .05), showShadow: false, borderRadius: 5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: landingPageController.panelTypes.length,
                          itemBuilder: (context, index) {
                            return InkWell(onTap: () => landingPageController.setSelectedPanelTypeIndex(index),
                              child: CustomContainer(showShadow: false,borderRadius: 3,horizontalPadding: 20,
                                color: index == landingPageController.selectedPanelTypeIndex? Theme.of(context).cardColor : Colors.transparent,
                                child: Center(child: Text(landingPageController.panelTypes[index].tr, style: textSemiBold.copyWith(color: index == landingPageController.selectedPanelTypeIndex? Theme.of(context).primaryColor : null),),)),
                            );
                          })
                    ),
                )),
              SizedBox(height: 436,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: landingPageController.cardData.length,
                  itemBuilder: (context, index) {
                    return DeliverableCarouselCard(panelModel: landingPageController.cardData[index]);
                  },
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
