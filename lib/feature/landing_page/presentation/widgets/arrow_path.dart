import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DashedCurvedArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size, ) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, -size.height / 50, size.width, size.height);

    // Dashed effect
    Path dashPath = Path();
    double dashWidth = 6, dashSpace = 4;
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashPath.addPath(pathMetric.extractPath(distance, distance + dashWidth),
            Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);

    // Draw Arrowhead
    Paint arrowPaint = Paint()
      ..color = Theme.of(Get.context!).primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double arrowSize = 10;
    Offset arrowStart = path.computeMetrics().last.getTangentForOffset(path.computeMetrics().last.length)!.position;
    double angle = atan2(size.height, size.width);

    Path arrowPath = Path();
    arrowPath.moveTo(arrowStart.dx, arrowStart.dy);
    arrowPath.lineTo(
        arrowStart.dx - arrowSize * cos(angle - pi / 6),
        arrowStart.dy - arrowSize * sin(angle - pi / 6));
    arrowPath.lineTo(
        arrowStart.dx - arrowSize * cos(angle + pi / 6),
        arrowStart.dy - arrowSize * sin(angle + pi / 6));
    arrowPath.close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class DashedReverseCurvedArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    Path path = Path();

    // Reverse the curve direction (bend downward instead of upward)
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 2, size.height * 1.5, size.width, 0);

    // Dashed effect
    Path dashPath = Path();
    double dashWidth = 6, dashSpace = 4;
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashPath.addPath(pathMetric.extractPath(distance, distance + dashWidth),
            Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);

    // Draw Arrowhead
    Paint arrowPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double arrowSize = 8;
    Offset arrowStart = path.computeMetrics().last.getTangentForOffset(path.computeMetrics().last.length)!.position;
    double angle = atan2(0 - size.height, size.width);

    Path arrowPath = Path();
    arrowPath.moveTo(arrowStart.dx, arrowStart.dy);
    arrowPath.lineTo(
        arrowStart.dx - arrowSize * cos(angle - pi / 6),
        arrowStart.dy - arrowSize * sin(angle - pi / 6));
    arrowPath.lineTo(
        arrowStart.dx - arrowSize * cos(angle + pi / 6),
        arrowStart.dy - arrowSize * sin(angle + pi / 6));
    arrowPath.close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
