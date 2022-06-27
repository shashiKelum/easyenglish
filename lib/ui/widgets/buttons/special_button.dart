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

import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color textColorDisabled;
  final Color color;
  final Color shadowColor;
  final Color colorDisabled;
  final Color shadowColorDisabled;
  final double width;
  final double height;
  final bool flipY;
  final double fontSize;

  const SpecialButton(
      {Key? key,
      this.text = LocaleKeys.button_continue,
      required this.onPressed,
      this.textColor = Colors.white,
      this.textColorDisabled = AppColors.textDisabled,
      this.color = AppColors.primary,
      this.shadowColor = AppColors.primaryDark,
      this.colorDisabled = AppColors.disabled,
      this.shadowColorDisabled = AppColors.disabledDark,
      this.width = 314.33,
      this.height = 71.05,
      this.flipY = false,
      this.fontSize = 20})
      : super(key: key);

  @override
  _SpecialButtonState createState() => _SpecialButtonState();
}

class _SpecialButtonState extends State<SpecialButton>
    with TickerProviderStateMixin {
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
      child: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform:
                  widget.flipY ? Matrix4.rotationY(pi) : Matrix4.identity(),
              child: CustomPaint(
                painter: ButtonBackgroundPainter(
                    animation.value,
                    widget.onPressed == null
                        ? widget.colorDisabled
                        : widget.color,
                    widget.onPressed == null
                        ? widget.shadowColorDisabled
                        : widget.shadowColor),
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8 - animation.value),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: widget.flipY
                            ? Matrix4.rotationY(pi)
                            : Matrix4.identity(),
                        child: Text(
                          widget.text.tr(),
                          style: AppStyle.text20SB.copyWith(
                              color: widget.onPressed == null
                                  ? widget.textColorDisabled
                                  : widget.textColor,
                              fontSize: widget.fontSize),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed == null) return;
    controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed == null) return;
    controller.reverse();
    widget.onPressed!();
  }

  void _onTapCancel() {
    if (widget.onPressed == null) return;
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
    final widthFactor = 314.33 / size.width;
    final heightFactor = 71.05 / size.height;

    // print('size => $size');
    // print('widthFactor => $widthFactor');
    // print('heightFactor => $heightFactor');

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

    canvas.drawPath(_getPath(4, widthFactor, heightFactor), shadowPaint);
    canvas.drawPath(_getPath(elevation, widthFactor, heightFactor), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path _getPath(double y, double widthFactor, double heightFactor) {
    var path = Path();

    path.moveTo(_getValue(17.5, widthFactor), _getValue(0 + y, heightFactor));

    var controlPoint1 =
        Offset(_getValue(270.02, widthFactor), _getValue(0 + y, heightFactor));
    var controlPoint2 = Offset(
        _getValue(275.25, widthFactor), _getValue(1.95 + y, heightFactor));
    var endPoint = Offset(
        _getValue(278.23, widthFactor), _getValue(5.16 + y, heightFactor));
    path.cubicTo(
      controlPoint1.dx,
      controlPoint1.dy,
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint.dx,
      endPoint.dy,
    );

    var _controlPoint1 = Offset(
        _getValue(288.64, widthFactor), _getValue(16.34 + y, heightFactor));
    var _controlPoint2 = Offset(
        _getValue(300.43, widthFactor), _getValue(27.01 + y, heightFactor));
    var _endPoint = Offset(
        _getValue(311.5, widthFactor), _getValue(37.95 + y, heightFactor));
    path.cubicTo(
      _controlPoint1.dx,
      _controlPoint1.dy,
      _controlPoint2.dx,
      _controlPoint2.dy,
      _endPoint.dx,
      _endPoint.dy,
    );

    var __controlPoint1 = Offset(
        _getValue(313.41, widthFactor), _getValue(39.84 + y, heightFactor));
    var __controlPoint2 = Offset(
        _getValue(314.3, widthFactor), _getValue(41.91 + y, heightFactor));
    var __endPoint = Offset(
        _getValue(314.33, widthFactor), _getValue(43.95 + y, heightFactor));
    path.cubicTo(
      __controlPoint1.dx,
      __controlPoint1.dy,
      __controlPoint2.dx,
      __controlPoint2.dy,
      __endPoint.dx,
      __endPoint.dy,
    );

    var ___controlPoint1 = Offset(
        _getValue(314.41, widthFactor), _getValue(49.41 + y, heightFactor));
    var ___controlPoint2 = Offset(
        _getValue(308.37, widthFactor), _getValue(54.49 + y, heightFactor));
    var ___endPoint = Offset(
        _getValue(299.3, widthFactor), _getValue(54.98 + y, heightFactor));
    path.cubicTo(
      ___controlPoint1.dx,
      ___controlPoint1.dy,
      ___controlPoint2.dx,
      ___controlPoint2.dy,
      ___endPoint.dx,
      ___endPoint.dy,
    );

    var ____controlPoint1 = Offset(
        _getValue(206.26, widthFactor), _getValue(60.01 + y, heightFactor));
    var ____controlPoint2 = Offset(
        _getValue(110.45, widthFactor), _getValue(66.06 + y, heightFactor));
    var ____endPoint = Offset(
        _getValue(17.6, widthFactor), _getValue(71.02 + y, heightFactor));
    path.cubicTo(
      ____controlPoint1.dx,
      ____controlPoint1.dy,
      ____controlPoint2.dx,
      ____controlPoint2.dy,
      ____endPoint.dx,
      ____endPoint.dy,
    );

    var _____controlPoint1 = Offset(
        _getValue(8.01, widthFactor), _getValue(71.53 + y, heightFactor));
    var _____controlPoint2 = Offset(
        _getValue(-0.15, widthFactor), _getValue(66.38 + y, heightFactor));
    var _____endPoint =
        Offset(_getValue(0, widthFactor), _getValue(59.93 + y, heightFactor));
    path.cubicTo(
      _____controlPoint1.dx,
      _____controlPoint1.dy,
      _____controlPoint2.dx,
      _____controlPoint2.dy,
      _____endPoint.dx,
      _____endPoint.dy,
    );

    var ______controlPoint1 = Offset(
        _getValue(0.39, widthFactor), _getValue(43.54 + y, heightFactor));
    var ______controlPoint2 = Offset(
        _getValue(0.79, widthFactor), _getValue(27.15 + y, heightFactor));
    var ______endPoint = Offset(
        _getValue(1.18, widthFactor), _getValue(10.76 + y, heightFactor));
    path.cubicTo(
      ______controlPoint1.dx,
      ______controlPoint1.dy,
      ______controlPoint2.dx,
      ______controlPoint2.dy,
      ______endPoint.dx,
      ______endPoint.dy,
    );

    var _______controlPoint1 =
        Offset(_getValue(1.32, widthFactor), _getValue(4.79 + y, heightFactor));
    var _______controlPoint2 =
        Offset(_getValue(8.58, widthFactor), _getValue(0 + y, heightFactor));
    var _______endPoint =
        Offset(_getValue(17.5, widthFactor), _getValue(0 + y, heightFactor));
    path.cubicTo(
      _______controlPoint1.dx,
      _______controlPoint1.dy,
      _______controlPoint2.dx,
      _______controlPoint2.dy,
      _______endPoint.dx,
      _______endPoint.dy,
    );

    path.close();
    return path;
  }

  double _getValue(double value, double factor) {
    return value / factor;
  }
}
