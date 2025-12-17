import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class WhatGetSections extends StatelessWidget {
  const WhatGetSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(decoration : ThemeShadow.getLandingPageDecoration(),
      padding: EdgeInsets.symmetric(vertical: Dimensions.landingPagePadding),
      child: Center(
        child: SizedBox(width: Dimensions.webMaxWidth,
          child: ResponsiveHelper.isDesktop(context)?
          Row(spacing: Dimensions.landingPagePadding, children: [
              Expanded(
                child: Container( padding: EdgeInsets.all(Dimensions.landingPagePadding),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor.withValues(alpha: 0.1)),
                  width: 530, height: 483, child: ClipRRect(borderRadius: BorderRadius.circular(10),
                    child: Image.asset(Images.whatGet, width: 500))),
              ),
              Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("what_will_you_get".tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 20),),
                    Text("designed_with_educational".tr, style: textBold.copyWith(color: Colors.white, fontSize: 40),),
                    const SizedBox(height: 10),
                    Text("what_get_details".tr, style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault,)),
                    const SizedBox(height: 30),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 26,vertical: 20),
                      decoration: BoxDecoration(color: Theme.of(context).cardColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeSmall, children: [
                          SizedBox(height: Dimensions.paddingSizeSmall),
                          ItemWidget(title: "details_1"),
                          ItemWidget(title: "details_2"),
                          ItemWidget(title: "details_3"),
                          ItemWidget(title: "details_4"),
                        ]))
                  ],
                ),
              )
            ],
          ):Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(spacing: Dimensions.landingPagePadding, children: [
              Container( padding: EdgeInsets.all(Dimensions.landingPagePadding),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor.withValues(alpha: 0.1)),
                  width: 530, height: 483, child: ClipRRect(borderRadius: BorderRadius.circular(10),
                      child: Image.asset(Images.whatGet, width: 500))),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("what_will_you_get".tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 20),),
                Text("designed_with_educational".tr, textAlign: TextAlign.center, style: textBold.copyWith(color: Theme.of(context).scaffoldBackgroundColor, fontSize: Dimensions.fontSizeExtraOverLarge),),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Text("what_get_details".tr,  textAlign: TextAlign.center, style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault,)),
                 SizedBox(height: Dimensions.landingPagePadding),
                Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeLarge),
                    decoration: BoxDecoration(color: Theme.of(context).cardColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeSmall, children: [
                      SizedBox(height: Dimensions.paddingSizeSmall),
                      ItemWidget(title: "details_1"),
                      ItemWidget(title: "details_2"),
                      ItemWidget(title: "details_3"),
                      ItemWidget(title: "details_4"),
                    ]))
              ],
              )
            ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String title;
  const ItemWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeSmall, children: [
        const Icon(Icons.check_circle, color: Colors.white, size: 20),
        Expanded(child: Text(title.tr, style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault),))],);
  }
}
