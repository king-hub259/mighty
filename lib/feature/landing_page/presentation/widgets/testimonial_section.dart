import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/landing_page/domain/models/testimonial_model.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class TestimonialSection extends StatelessWidget {
  const TestimonialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      builder: (landingPageController) {
        TestimonialModel? testimonialModel = TestimonialModel.fromJson(sampleTestimonial);
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.landingPagePadding),
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, spacing: Dimensions.paddingSizeSmall,children: [
                  Text("testimonials".tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 20),),
                  Text("${"success_stories".tr} ${AppConstants.appName}", style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeExtraOverLarge),textAlign: TextAlign.center,),

                  SizedBox(height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: testimonialModel.data?.length,
                      itemBuilder: (context, index) {
                        return TestimonialCard(item: testimonialModel.data?[index]);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}



class TestimonialCard extends StatelessWidget {
  final TestimonialItem? item;
  const TestimonialCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0),
      child: Column(children: [
          CustomContainer(width: 250,
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Text(item?.description??'', maxLines: 3,overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start, style: textRegular.copyWith( color: Theme.of(context).hintColor))),
                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: CustomDivider()),
                Row(spacing: Dimensions.paddingSizeSmall, children: [
                    CustomImage(width: 50, height: 50, image: item?.user?.image, radius: 5),

                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(item?.user?.name??'',textAlign: TextAlign.start, style: textBold.copyWith(fontSize: Dimensions.paddingSizeLarge,
                              color: Theme.of(context).colorScheme.primary)),
                          Text(item?.user?.email??'', maxLines: 1, overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
