import 'package:easyenglish/ui/theme/color.dart';
import 'package:flutter/material.dart';

class BottomStatusPainter extends CustomPainter {
  final bool isPass;

  BottomStatusPainter(this.isPass);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()
          ..addOval(Rect.fromLTWH(
            size.width * -0.4,
            0,
            size.width + (size.width * 0.8),
            size.height + (size.height * 0.5),
          ))
          ..fillType = PathFillType.evenOdd,
        Paint()
          ..color = (isPass ? AppColors.gamePassColor : AppColors.gameFailColor)
          ..maskFilter =
              MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(10)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }
}
