import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
        child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
          child: Row(children: [
            const CustomImage(width: Dimensions.imageSize, height: Dimensions.imageSize, image: "",),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit in, sed do eiusmod tempor incididunt ut labore et",
              style: textRegular.copyWith()),
            ),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Text("2022-01-01", style: textRegular.copyWith()),
            const SizedBox(width: Dimensions.paddingSizeDefault),

            IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz))
          ],),
        ),
      );
    });
  }
}
