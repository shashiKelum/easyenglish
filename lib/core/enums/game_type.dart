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
import 'package:flutter/material.dart';

enum GameType { G1, G2, G3, G4 }

extension GameTypeExtension on GameType {
  String get name {
    switch (this) {
      case GameType.G1:
        return 'Match the Word!';
      case GameType.G2:
        return 'Listen & Pick!';
      case GameType.G3:
        return 'Read & Repeat!';
      case GameType.G4:
        return 'Fill the Sentence!';
    }
  }

  String get action {
    switch (this) {
      case GameType.G1:
        return 'G1';
      case GameType.G2:
        return 'G2';
      case GameType.G3:
        return 'G3';
      case GameType.G4:
        return 'G4';
    }
  }

  ImageProvider get image {
    switch (this) {
      case GameType.G1:
        return R.image.img_game_1();
      case GameType.G2:
        return R.image.img_game_2();
      case GameType.G3:
        return R.image.img_game_3();
      case GameType.G4:
        return R.image.img_game_4();
    }
  }

  Color get color {
    switch (this) {
      case GameType.G1:
        return AppColors.game1Color;
      case GameType.G2:
        return AppColors.game2Color;
      case GameType.G3:
        return AppColors.game3Color;
      case GameType.G4:
        return AppColors.game4Color;
    }
  }

  Color get shadowColor {
    switch (this) {
      case GameType.G1:
        return AppColors.game1ShadowColor;
      case GameType.G2:
        return AppColors.game2ShadowColor;
      case GameType.G3:
        return AppColors.game3ShadowColor;
      case GameType.G4:
        return AppColors.game4ShadowColor;
    }
  }

  Color get percentageColor {
    switch (this) {
      case GameType.G1:
        return AppColors.game1PercentageColor;
      case GameType.G2:
        return AppColors.game2PercentageColor;
      case GameType.G3:
        return AppColors.game3PercentageColor;
      case GameType.G4:
        return AppColors.game4PercentageColor;
    }
  }

  Color get percentageShadowColor {
    switch (this) {
      case GameType.G1:
        return AppColors.game1PercentageShadowColor;
      case GameType.G2:
        return AppColors.game2PercentageShadowColor;
      case GameType.G3:
        return AppColors.game3PercentageShadowColor;
      case GameType.G4:
        return AppColors.game4PercentageShadowColor;
    }
  }
}
