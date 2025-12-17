import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class FooterLeftPortion extends StatelessWidget {
  const FooterLeftPortion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: ResponsiveHelper.isDesktop(context)? CrossAxisAlignment.start : CrossAxisAlignment.center, children: [
          const CustomImage(height: 40, image: Images.logo, localAsset: true),
           SizedBox(height: ResponsiveHelper.isDesktop(context)? 30 : Dimensions.paddingSizeDefault),
          Text(AppConstants.slogan,
            style: textRegular.copyWith(color: Theme.of(context).hintColor),),
           SizedBox(height: ResponsiveHelper.isDesktop(context)? 40: Dimensions.paddingSizeDefault),
           Row(spacing: Dimensions.paddingSizeDefault,
             mainAxisAlignment: ResponsiveHelper.isDesktop(context)? MainAxisAlignment.start: MainAxisAlignment.center, children: const [
            Icon(FontAwesomeIcons.facebook, color: Colors.white70, size: 20),
            Icon(FontAwesomeIcons.twitter, color: Colors.white70, size: 20),
            Icon(FontAwesomeIcons.linkedin, color: Colors.white70, size: 20),
          ],
          )
        ],
      ),
    );
  }
}
