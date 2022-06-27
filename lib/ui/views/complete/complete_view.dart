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
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:flutter/material.dart';

class CompleteView extends StatelessWidget {
  final String title;
  final String buttonText;
  final int level;
  final VoidCallback onTabButton;

  const CompleteView(
      {Key? key,
      required this.title,
      required this.buttonText,
      required this.level,
      required this.onTabButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: R.image.bg_completion(),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
        color: AppColors.primary,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.8),
              Colors.transparent,
            ],
            begin: Alignment(0, 0.4),
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image(
                image: R.svg.ic_trophy(width: 275, height: 400),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$title Complete!',
                    style: AppStyle.text38SB.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Level $level',
                    style: AppStyle.text18B.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  SpecialButton(
                    onPressed: onTabButton,
                    text: buttonText,
                    textColor: Colors.white,
                    color: AppColors.accent,
                    shadowColor: AppColors.accentDark,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
