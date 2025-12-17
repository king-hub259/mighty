import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/landing_page/domain/models/key_feature_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class KeyFeaturesWidget extends StatefulWidget {
  const KeyFeaturesWidget({super.key,});

  @override
  State<KeyFeaturesWidget> createState() => _KeyFeaturesWidgetState();
}

class _KeyFeaturesWidgetState extends State<KeyFeaturesWidget> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width : Dimensions.webMaxWidth,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("key_features".tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 20),),
            Text("all_in_one_solution".tr, style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeExtraOverLarge),textAlign: TextAlign.center,),
            const SizedBox(height: 10),
            Container(height: 3, width: 60, decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).primaryColor),),
            const SizedBox(height: Dimensions.paddingSizeOver),

            Row(children: [
              if(ResponsiveHelper.isDesktop(context))
              InkWell(onTap: (){
                scrollController.animateTo(
                  scrollController.offset - 200,
                  duration:
                  const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
                  child: const CircleAvatar(child: Icon(Icons.arrow_back))),
                Expanded(
                  child: SizedBox(height: 273,
                    child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: keyFeatures.length,
                      itemBuilder: (context, index) {
                        return Padding(padding: const EdgeInsets.all(5.0),
                          child: CustomContainer(width: 273, showShadow: false, borderRadius: 5,color: Theme.of(context).highlightColor.withValues(alpha: .25),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                CustomImage(svg: keyFeatures[index].imagePath,),
                                const SizedBox(height: 27),
                                Text(keyFeatures[index].title, style: textSemiBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: 20),textAlign: TextAlign.center,),
                                const SizedBox(height: 10),
                                Text(keyFeatures[index].description, textAlign: TextAlign.center, style: textRegular.copyWith(color: Theme.of(context).hintColor),)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              if(ResponsiveHelper.isDesktop(context))
              InkWell(onTap: (){
                scrollController.animateTo(
                  scrollController.offset + 200,
                  duration:
                  const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
                  child: const CircleAvatar(child: Icon(Icons.arrow_forward),)),
              ],
            ),
            // const SizedBox(height: 50),
            // CustomButton(onTap: (){}, text: "more_features"),
          ],
        ),
      ),
    );
  }
}
