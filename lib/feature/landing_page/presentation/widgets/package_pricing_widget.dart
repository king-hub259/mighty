import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/digital_payment/logic/digital_payment_controller.dart';
import 'package:mighty_school/feature/institute/controller/institute_controller.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/feature/package_plan/domain/models/package_model.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PackagePricingWidget extends StatelessWidget {
  const PackagePricingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val) => Get.find<LandingPageController>().getSubscriptionPlanList(),
        builder: (landingPageController) {
          PackageModel? pricingPlanModel = landingPageController.packageModel;
          return pricingPlanModel != null?
          SizedBox(width: Dimensions.webMaxWidth,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeSmall,children: [
              Text("pricing".tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 20),),
              Text("choose_right_package".tr, style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeExtraOverLarge),textAlign: TextAlign.center,),
              Text("pricing_details".tr, style: textBold.copyWith(color: Theme.of(context).hintColor),textAlign: TextAlign.center,),

              SizedBox(height: 350,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: pricingPlanModel.data?.data?.length,
                  itemBuilder: (context, index) {
                    return PricingItemWidget(item: pricingPlanModel.data?.data?[index], index: index,);
                  },
                ),
              )
            ],
            ),
          ): const SizedBox();
        }
    );
  }
}



class PricingItemWidget extends StatelessWidget {
  final PackageItem? item;
  final int index;
  const PricingItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstituteController>(
      builder: (instituteController) {
        return GetBuilder<DigitalPaymentController>(
          builder: (digitalPaymentController) {
            return GetBuilder<LandingPageController>(
              builder: (landingPageController) {
                bool selected = landingPageController.selectedPackageIndex == index;
                return Padding(padding: const EdgeInsets.all(8.0),
                  child: Column(spacing: Dimensions.paddingSizeSmall, children: [
                    Container(width: ResponsiveHelper.isDesktop(Get.context!)? 240 : 270, padding: const EdgeInsets.all( Dimensions.paddingSizeLarge),
                     decoration: BoxDecoration(
                        color: selected?  Theme.of(context).primaryColor : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        boxShadow: selected ? [
                        BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: .15), blurRadius: 10, spreadRadius: 5, offset: const Offset(0, 1) ),

                        ] : [
                          BoxShadow(color: Theme.of(context).hintColor.withValues(alpha: .5), blurRadius: 1, spreadRadius: 1,offset: const Offset(0, 1) ),
                          BoxShadow(color: Theme.of(context).hintColor.withValues(alpha: .5), blurRadius: 1, spreadRadius: 1, offset: const Offset(1, 0) ),
                        ],
                     ),
                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(PriceConverter.convertPrice(context, item?.price??0),
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraOverLarge, color: selected? Colors.white : null)),
                        Text(item?.name??'', style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: selected? Colors.white : null)),

                        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                          child: Text(item?.description??'', maxLines: 3,overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start, style: textRegular.copyWith(color: selected? Colors.white :  Theme.of(context).hintColor))),

                        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            DetailsItem(item: "${"branch_limit".tr}: ${item?.branchLimit??0}", isMostPopular: selected),
                            DetailsItem(item: "${"student_limit".tr}: ${item?.studentLimit??0}", isMostPopular: selected),
                            DetailsItem(item: "${"duration".tr}: ${item?.durationDays??0} ${"days".tr}", isMostPopular: selected),

                          ]),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        CustomButton(onTap: (){
                          if(AppConstants.demo){
                            if(index == 0){
                              Get.find<LandingPageController>().setSelectedPackageItem(item!, index);
                            }else{
                              showCustomSnackBar("you_can_only_select_the_trail_plan_in_demo".tr);
                            }

                          }else {
                            Get.find<LandingPageController>().setSelectedPackageItem(item!, index);
                          }
                        }, text: "choose_plan".tr, textColor: selected? Theme.of(context).primaryColor : Colors.white,
                            buttonColor : selected? Colors.white:Theme.of(context).primaryColor)

                      ],
                      ),
                    ),
                  ],
                  ),
                );
              }
            );
          }
        );
      }
    );
  }
}
class DetailsItem extends StatelessWidget {
  final String? item;
  final bool isMostPopular;
  const DetailsItem({super.key, this.item, this.isMostPopular = false});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(spacing: Dimensions.paddingSizeSmall, children: [
        Icon(Icons.check_circle, color: isMostPopular? Colors.white : Theme.of(context).primaryColor.withValues(alpha: .25), size: 15),
        Expanded(child: Text(item??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
            color: isMostPopular? Colors.white : null))),
      ]),
    );
  }
}
