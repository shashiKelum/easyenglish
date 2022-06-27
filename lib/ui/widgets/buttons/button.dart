/*
 * Copyright 2021 CeylonCodeLabs. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:easyenglish/ui/theme/color.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color color;
  final Color disabledColor;
  final Color shadowColor;
  final Color disabledShadowColor;
  final VoidCallback? onTap;
  final bool enabled;

  const Button(
      {Key? key,
      required this.child,
      this.width = 40,
      this.height = 40,
      this.color = AppColors.buttonDefault,
      this.disabledColor = AppColors.buttonDefaultDisabled,
      this.shadowColor = AppColors.buttonDefaultShadow,
      this.disabledShadowColor = AppColors.buttonDefaultDisabledShadow,
      this.onTap,
      this.enabled = true})
      : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    Tween<double> _elevationTween = Tween(begin: 0.0, end: 4.0);

    animation = _elevationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return CustomPaint(
            painter: ButtonBackgroundPainter(
                animation.value,
                !widget.enabled ? widget.disabledColor : widget.color,
                !widget.enabled
                    ? widget.disabledShadowColor
                    : widget.shadowColor),
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: EdgeInsets.only(top: animation.value),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.enabled) return;
    controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.enabled) return;
    controller.reverse();
    if (widget.onTap != null && widget.enabled) widget.onTap!();
  }

  void _onTapCancel() {
    if (!widget.enabled) return;
    controller.reverse();
  }
}

class ButtonBackgroundPainter extends CustomPainter {
  final double elevation;
  final Color color;
  final Color shadowColor;

  ButtonBackgroundPainter(this.elevation, this.color, this.shadowColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var shadowPaint = Paint()
      ..color = shadowColor
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(_getPath(size, 4), shadowPaint);
    canvas.drawPath(_getPath(size, elevation), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path _getPath(Size size, double y) {
    var path = Path();
    final double radius = 10;

    path.moveTo(radius, 0 + y);
    path.lineTo(size.width - radius, 0 + y);
    path.arcToPoint(Offset(size.width, radius + y),
        radius: Radius.circular(radius));
    path.lineTo(size.width, size.height - radius + y);
    path.arcToPoint(Offset(size.width - radius, size.height + y),
        radius: Radius.circular(radius));
    path.lineTo(radius, size.height + y);
    path.arcToPoint(Offset(0, size.height - radius + y),
        radius: Radius.circular(radius));
    path.lineTo(0, radius + y);
    path.arcToPoint(Offset(radius, 0 + y), radius: Radius.circular(radius));

    path.close();
    return path;
  }
}
