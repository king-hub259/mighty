import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor), width: Get.width,
        height: 40,
        child: Center(
          child: Marquee(
            text: 'Streamline Your School Operations — All in One Powerful Platform.',
            style:  textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault),
            scrollAxis: Axis.horizontal,
            blankSpace: 20.0,
            velocity: 100.0,
            pauseAfterRound: const Duration(seconds: 1),
            startPadding: 10.0,
            accelerationDuration: const Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: const Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ));
  }
}
