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

enum GameState { Pending, Current, Pass, Fail }

extension GameStateExtension on GameState {
  Color get stateColor {
    switch (this) {
      case GameState.Pending:
        return AppColors.gameStatePendingColor;
      case GameState.Current:
        return AppColors.gameStateCurrentColor;
      case GameState.Pass:
        return AppColors.gameStatePassColor;
      case GameState.Fail:
        return AppColors.gameStateFailColor;
    }
  }

  Color get stateDarkColor {
    switch (this) {
      case GameState.Pending:
        return AppColors.gameStatePendingDarkColor;
      case GameState.Current:
        return AppColors.gameStateCurrentDarkColor;
      case GameState.Pass:
        return AppColors.gameStatePassDarkColor;
      case GameState.Fail:
        return AppColors.gameStateFailDarkColor;
    }
  }
}
