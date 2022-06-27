import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AnimWidget extends StatelessWidget {
  final int? index;
  final Axis? axis;
  final Widget child;
  final int delay;
  final int duration;

  const AnimWidget(
      {Key? key,
      this.axis,
      required this.child,
      this.index = 0,
      this.delay = 100,
      this.duration = 500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int delayAdd = (delay + (delay * 0.5 * (index ?? 0)).round());
    switch (axis) {
      case Axis.horizontal:
        return FadeInRight(
          delay: Duration(milliseconds: delayAdd),
          duration: Duration(milliseconds: duration),
          from: 10,
          child: child,
        );
      case Axis.vertical:
        return FadeInUp(
          delay: Duration(milliseconds: delayAdd),
          duration: Duration(milliseconds: 500),
          from: 10,
          child: child,
        );
      default:
        return FadeIn(
          delay: Duration(milliseconds: delayAdd),
          duration: Duration(milliseconds: 500),
          child: child,
        );
    }
  }
}
