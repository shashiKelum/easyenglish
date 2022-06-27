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

import 'package:easyenglish/ui/custom/painters/bottom_status_painter.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:flutter/material.dart';

import '../../r.g.dart';
import 'monkey_widget.dart';

class GameItemResult extends StatelessWidget {
  final bool isCorrect;
  const GameItemResult({Key? key, required this.isCorrect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Positioned(
            bottom: -25,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: BottomStatusPainter(isCorrect),
              child: Container(height: 100),
            ),
          ),
          Container(
            height: 145,
            margin: const EdgeInsets.only(left: 46),
            child: MonkeyWidget(
              monkeyTop: 48,
              monkey: isCorrect
                  ? R.image.img_monkey_6()
                  : R.image.img_monkey_5(),
              background: isCorrect
                  ? R.image.bg_hint()
                  : R.image.bg_hint_fail(),
              text:
              isCorrect ? 'Grate Job!' : 'Aww.. Too Bad',
              textStyle: AppStyle.text24SB.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
