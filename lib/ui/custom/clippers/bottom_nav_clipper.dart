import 'package:flutter/material.dart';

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(
      Rect.fromLTWH(
        size.width * -0.2,
        0,
        size.width + (size.width * 0.4),
        size.height + (size.height * 0.5),
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
