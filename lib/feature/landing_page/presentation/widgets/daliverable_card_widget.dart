import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/landing_page/domain/models/panel_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';
class DeliverableCarouselCard extends StatelessWidget {
  final PanelModel? panelModel;
  const DeliverableCarouselCard({super.key, this.panelModel});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(5.0),
      child: CustomContainer(color: Theme.of(context).primaryColor.withValues(alpha: .125),
        showShadow: false, horizontalPadding: 0,verticalPadding: 0,
        width: 273, borderRadius: Dimensions.paddingSizeExtraSmall,
        child: Column(spacing: Dimensions.paddingSizeDefault, children: [
          const SizedBox(height: 5),
            Text(panelModel?.title??'', style:textRegular.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: 20)),
            SizedBox(height: 50, child: Text(panelModel?.subtitle??'',textAlign: TextAlign.center, maxLines: 3,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: 14))),

          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("explore_demo".tr, style: textRegular.copyWith(decoration: TextDecoration.underline)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward, size: 16))
          ]),

          const CustomImage(image : Images.demoPanel, width: 275,localAsset: true)
          ]),
      ),
    );
  }
}
