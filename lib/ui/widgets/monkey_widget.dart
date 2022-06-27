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

import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:flutter/material.dart';

class MonkeyWidget extends StatelessWidget {
  final ImageProvider monkey;
  final ImageProvider? background;
  final double monkeyWidth;
  final double monkeyHeight;
  final double monkeyTop;
  final String text;
  final double textLeftOffset;
  final TextStyle textStyle;

  const MonkeyWidget(
      {Key? key,
      required this.monkey,
      required this.text,
      this.background,
      this.monkeyWidth = 85.13,
      this.monkeyHeight = 75.09,
      this.monkeyTop = 80,
      this.textLeftOffset = 60,
      this.textStyle = AppStyle.text14SB})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          width: monkeyWidth,
          height: monkeyHeight,
          top: monkeyTop,
          child: Image(image: monkey),
        ),
        Positioned(
          left: textLeftOffset,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: background ?? R.image.bg_hint(), fit: BoxFit.fill),
            ),
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 32),
            child: Text(text, style: textStyle),
          ),
        ),
      ],
    );
  }
}
