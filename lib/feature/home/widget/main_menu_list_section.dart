
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class MainMenuListSection extends StatelessWidget {
  const MainMenuListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuTypeController>(
      builder: (mainMenuController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: Column(spacing: Dimensions.paddingSizeSmall, children: [
              CustomTitle(title: "quick_links", fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.bold),
              SizedBox(height: 120,
                child: ListView.builder(
                    itemCount: mainMenuController.mainItem.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {

                  return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeTiny),
                    child: CustomContainer(borderRadius: 5,width: 150,
                      child: InkWell(onTap: ()=> Get.to(()=> mainMenuController.mainItem[index].widget),
                        child: Column(mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeExtraSmall,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,  children: [
                          SizedBox(height: 30, child: Image.asset(mainMenuController.mainItem[index].icon)),
                          Text(mainMenuController.mainItem[index].title.tr, textAlign: TextAlign.start,
                              maxLines: 2,overflow: TextOverflow.ellipsis,
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),

                        ],),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      }
    );
  }
}
