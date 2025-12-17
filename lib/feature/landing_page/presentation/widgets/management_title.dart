import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';


class ManagementTile extends StatelessWidget {
  const ManagementTile({super.key, required this.title, required this.description, required this.image,});
  final String title;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeLarge, children: [
        Container(height: 50,width: 50,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)),
          child: Center(child: CustomImage(svg: image))),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: 20),),
              const SizedBox(height: 5),
              Text(description),

            ],
          ),
        )
      ],
    );
  }
}
