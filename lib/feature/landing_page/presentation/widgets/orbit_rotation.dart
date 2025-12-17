import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'dart:math' as math;

import 'package:mighty_school/util/images.dart';

class OrbitRotation extends StatefulWidget {
  const OrbitRotation({super.key});
  @override
  State<OrbitRotation> createState() => _OrbitRotationState();
}

class _OrbitRotationState extends State<OrbitRotation> with TickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> animation2;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 60))..repeat();
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    animation2 = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose(); // ✅ Dispose the ticker
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // Responsive sizes
    final double outerCircle = screenWidth < 500 ? screenWidth * 0.85 : 400;
    final double innerCircle = screenWidth < 500 ? screenWidth * 0.45 : 200;
    final double iconPadding = screenWidth < 500 ? 8 : 16;
    final double iconSize = screenWidth < 500 ? 18 : 30;

    return Center(
      child: Stack(alignment: Alignment.center, children: [
        const CustomImage(svg: Images.appIcon, width: 40,),
        RotationTransition(
          turns: animation2,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              DottedBorder(
                dashPattern: const [10],
                borderType: BorderType.Circle,
                color: Theme.of(context).primaryColor,
                strokeWidth: 1.8,
                child: SizedBox(height: outerCircle, width: outerCircle),
              ),
              Positioned(top: outerCircle * 0.13, right: outerCircle * 0.025, child: IconCard(image: Images.windowsLogo, padding: iconPadding, animation: animation2)),
              Positioned(bottom: outerCircle * 0.43, right: -outerCircle * 0.037, child: Icon(Icons.circle, color: Colors.yellow, size: iconSize)),
              Positioned(bottom: outerCircle * 0.1, right: outerCircle * 0.05, child: IconCard(image: Images.meetLogo, padding: iconPadding, animation: animation2)),
              Positioned(bottom: outerCircle * 0.075, left: outerCircle * 0.075, child: IconCard(image: Images.appleLogo, padding: iconPadding, animation: animation2)),
              Positioned(left: 0, bottom: outerCircle * 0.275, child: Icon(Icons.circle, color: Colors.green, size: iconSize)),
              Positioned(top: outerCircle * 0.375, left: -outerCircle * 0.062, child: IconCard(image: Images.macLogo, padding: iconPadding, animation: animation2)),
              Positioned(left: outerCircle * 0.16, top: outerCircle * 0.062, child: Icon(Icons.circle, color: Colors.orange, size: iconSize)),
              Positioned(top: -outerCircle * 0.062, right: outerCircle * 0.5, child: IconCard(image: Images.laravelLogo, padding: iconPadding, animation: animation2)),
            ],
          ),
        ),
        RotationTransition(
          turns: animation,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              DottedBorder(
                dashPattern: const [10],
                borderType: BorderType.Circle,
                color: Theme.of(context).primaryColor,
                strokeWidth: 1.8,
                child: SizedBox(height: innerCircle, width: innerCircle),
              ),
              Positioned(
                  top: -innerCircle * 0.15,
                  child: IconCard(image: Images.flutterLogo, padding: iconPadding, animation: animation)),
              Positioned(
                  bottom: -innerCircle * 0.15,
                  child: IconCard(image: Images.androidLogo, padding: iconPadding, animation: animation)),
              Positioned(left: -innerCircle * 0.06, child: Icon(Icons.circle, color: Colors.blue, size: iconSize)),
              Positioned(right: -innerCircle * 0.06, child: Icon(Icons.circle, color: Colors.red, size: iconSize)),
            ],
          ),
        )
      ]),
    );
  }
}

class IconCard extends StatelessWidget {
  const IconCard({super.key, required this.image, this.isCircular = true, required this.padding, required this.animation,});
  final String image;
  final bool isCircular;
  final double padding;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: -animation.value * 2 * math.pi,
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isCircular ? null: BorderRadius.circular(8),
              shape: isCircular? BoxShape.circle: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset:  const Offset(0, 6),)
              ]
            ),
            child: SvgPicture.asset(image),
          ),
        );
      }
    );
  }
}
