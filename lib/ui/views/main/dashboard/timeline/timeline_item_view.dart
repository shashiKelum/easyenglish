import 'package:easyenglish/core/methods/typedefs.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:flutter/material.dart';

class TimelineItemView extends StatelessWidget {
  final int level;
  final int unit;
  final String title;
  final String description;
  final ImageProvider image;
  final Alignment textAlignment;
  final Callback<Map> callback;

  const TimelineItemView(
      {Key? key,
      required this.level,
      required this.unit,
      required this.title,
      required this.description,
      required this.image,
      required this.textAlignment,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (textAlignment == Alignment.centerRight)
          Expanded(child: Image(image: image)),
        if (textAlignment == Alignment.centerLeft) SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppStyle.text24SB,
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: AppStyle.text18R,
              ),
              SizedBox(height: 4),
              IconButton(
                onPressed: () => callback({'level': level, 'unit': unit}),
                icon: Image(
                  image: R.svg.ic_arrow_right(width: 23.85, height: 19.84),
                ),
              ),
            ],
          ),
        ),
        if (textAlignment == Alignment.centerLeft)
          Expanded(child: Image(image: image)),
      ],
    );
  }
}
