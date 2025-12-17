import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [


      Padding(padding: const EdgeInsets.all(8.0),
        child: Row(children: [
           Stack(clipBehavior: Clip.none, children: [
               const CustomImage(image: Images.profileIcon, localAsset: true,  width: Dimensions.profileImageSize, height: Dimensions.profileImageSize,forCircleImage: true,),

            Positioned(bottom: -5, right: -5, child: CircleAvatar(backgroundColor: Theme.of(context).primaryColor,
              radius: 10,child: const Icon(Icons.edit, size: 13,),))]),

          const SizedBox(width: Dimensions.paddingSizeSmall,),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Mr John Doe", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("+1 (123) 435 2222", style: textRegular.copyWith(),),
            Text("example@gmail.com", style: textRegular.copyWith(),),
          ]))
        ],),
      )
    ],);
  }
}
