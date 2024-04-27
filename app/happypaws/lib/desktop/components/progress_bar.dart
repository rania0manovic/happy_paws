import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:happypaws/common/utilities/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double progress;

  CustomProgressIndicator({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: CustomPaint(
                painter: ProgressPainter(progress: progress),
                child: const SizedBox( width: 200,))),
        Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: CustomPaint(
                  painter: ProgressPainter(progress: progress),
                  child: const SizedBox(width: 200,)),
            )),
        Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: 200,
                child: Center(
                    child: Text(
              "75%",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: AppColors.primary),
            )))),
      ],
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;

  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 20;
    final double radius = (size.shortestSide - strokeWidth) / 2;
    final double center = size.shortestSide / 2;

    Paint outerCircle = Paint()
      ..color = AppColors.primaryLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint innerCircle = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(Offset(center, center), radius, outerCircle);

    final double arcAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(center, center), radius: radius),
      -math.pi / 2,
      arcAngle,
      false,
      innerCircle,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
