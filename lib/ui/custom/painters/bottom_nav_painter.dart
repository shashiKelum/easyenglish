import 'package:easyenglish/ui/theme/color.dart';
import 'package:flutter/material.dart';

class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()
          ..addOval(Rect.fromLTWH(
            size.width * -0.2,
            0,
            size.width + (size.width * 0.4),
            size.height + (size.height * 0.5),
          ))
          ..fillType = PathFillType.evenOdd,
        Paint()
          ..color = AppColors.shadow1.withAlpha(16)
          ..maskFilter =
              MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(10)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }
}
