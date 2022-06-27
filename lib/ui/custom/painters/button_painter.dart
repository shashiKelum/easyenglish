import 'package:flutter/material.dart';

class ButtonPainter extends CustomPainter {
  final double radius;
  final Color color;

  ButtonPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    var pathRec = Path();

    canvas.clipRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(radius)));
    canvas.drawColor(color, BlendMode.color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
