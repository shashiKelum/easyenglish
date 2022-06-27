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

import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = const Color(0xFF00CED1);
  static const Color primaryLight = const Color(0xFFEFFFFF);
  static const Color primaryDark = const Color(0xFF00A0A2);
  static const Color secondary = const Color(0xFFFFB200);
  static const Color secondaryDark = const Color(0xFFD9A221);
  static const Color disabled = const Color(0xFFDFDFDF);
  static const Color disabledDark = const Color(0xFFB1B1B1);
  static const Color accent = const Color(0xFFFF4755);
  static const Color accentDark = const Color(0xFFD5000F);

  static const Color gray1 = const Color(0xFF7A7D89);
  static const Color gray2 = const Color(0xFF828282);
  static const Color gray3 = const Color(0xFF8A8A8A);
  static const Color gray4 = const Color(0xFF5D5D5D);
  static const Color gray5 = const Color(0xFFDEDEDE);
  static const Color gray6 = const Color(0xFFBBBBBB);
  static const Color gray7 = const Color(0xFFEFEFEF);
  static const Color gray8 = const Color(0xFF5E616E);

  static const Color red = const Color(0xFFFF0000);
  static const Color maroon = const Color(0xFF820606);
  static const Color blue = const Color(0xFF0066FF);
  static const Color darkBlue = const Color(0xFF054AB1);
  static const Color green = const Color(0xFF84BC42);

  static const Color error = red;
  static const Color success = green;
  static const Color info = primary;

  static Color textFieldNormal = border1;
  static const Color textFieldLabel = const Color(0xFF8A8A8A);
  static Color textFieldHint = Colors.black.withOpacity(0.5);
  static const Color textFieldFocused = primary;
  static Color textFieldDisabled = Colors.black.withOpacity(0.2);
  static const Color textFieldError = error;
  static Color textFieldHelper = Color(0xFF626262).withOpacity(0.7);
  static const Color textFieldFill = Color(0xFFF2F2F2);

  static const Color shadow1 = Color(0xFFBAA9DA);
  static const Color shadow2 = Color(0xFFC6CBD4);
  static const Color shadow3 = Color(0x298AADFF);

  static const Color appbarBackground = Colors.transparent;

  //region project
  static const Color progressBackground = Color(0xFFE5E5E5);
  static const Color progressValue = Color(0xFFED1A2C);

  static const Color border1 = Color(0xFFE5E5E5);

  static const Color background = Color(0xFFF7F9FB);

  static const Color textPrimary = Color(0xFF040729);
  static const Color textHighlight = Color(0xFFFF901D);
  static const Color textDisabled = Color(0xFFB1B1B1);

  static const Color buttonDefault = const Color(0xffffffff);
  static const Color buttonDefaultDisabled = const Color(0xffdfdfdf);
  static const Color buttonDefaultShadow = const Color(0xffdcdcdc);
  static const Color buttonDefaultDisabledShadow = const Color(0xffb1b1b1);

  static const Color bookDisabled = const Color(0xCB000000);

  //region game
  static const Color gameStatePendingColor = const Color(0xFFE5E5E5);
  static const Color gameStatePendingDarkColor = const Color(0xFFE5E5E5);
  static const Color gameStateCurrentColor = secondary;
  static const Color gameStateCurrentDarkColor = const Color(0xFFEBC368);
  static const Color gameStatePassColor = const Color(0xFF78C93C);
  static const Color gameStatePassDarkColor = const Color(0xFF6BA530);
  static const Color gameStateFailColor = const Color(0xFFFAE0E0);
  static const Color gameStateFailDarkColor = const Color(0xFFEB5953);

  static const Color gamePassColor = const Color(0xFFDEFEBF);
  static const Color gamePassShadowColor = const Color(0xFF78C93C);
  static const Color gameFailColor = const Color(0xFFFAE0E0);
  static const Color gameFailShadowColor = const Color(0xFFEB5953);

  static const Color game1Color = const Color(0xFFE1F0FF);
  static const Color game1ShadowColor = const Color(0xFF6182A2);
  static const Color game1PercentageColor = const Color(0xFF4FA2F3);
  static const Color game1PercentageShadowColor = const Color(0xFF6182A2);
  static const Color game2Color = const Color(0xFFFFDE91);
  static const Color game2ShadowColor = const Color(0xFFD4A028);
  static const Color game2PercentageColor = const Color(0xFFD4A028);
  static const Color game2PercentageShadowColor = const Color(0xFFD4A028);
  static const Color game3Color = const Color(0xFFFFE0CC);
  static const Color game3ShadowColor = const Color(0xFFB29960);
  static const Color game3PercentageColor = const Color(0xFFB29960);
  static const Color game3PercentageShadowColor = const Color(0xFFB29960);
  static const Color game4Color = const Color(0xFFD9EEFF);
  static const Color game4ShadowColor = const Color(0xFF6482BE);
  static const Color game4PercentageColor = const Color(0xFF6482BE);
  static const Color game4PercentageShadowColor = const Color(0xFF6482BE);
//endregion
//endregion
}
