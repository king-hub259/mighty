import 'package:flutter/material.dart';
import 'package:mighty_school/util/dimensions.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double? verticalPadding;
  final double? horizontalPadding;
  const CustomDivider({super.key, this.height = 1, this.color = Colors.grey, this.verticalPadding, this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Padding(padding: EdgeInsets.symmetric(vertical: verticalPadding??Dimensions.paddingSizeExtraSmall, horizontal: horizontalPadding??0),
          child: Flex(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(width: dashWidth, height: dashHeight,
                child: DecoratedBox(decoration: BoxDecoration(color: color)));
            }),
          ),
        );
      },
    );
  }
}