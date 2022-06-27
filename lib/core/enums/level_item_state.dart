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

enum LevelState { Pending, Active, Complete }

extension LevelStateExtension on LevelState {
  Color get stateColor {
    switch (this) {
      case LevelState.Pending:
        return AppColors.gameStatePendingColor;
      case LevelState.Active:
        return AppColors.gameStateCurrentColor;
      case LevelState.Complete:
        return AppColors.gameStatePassColor;
    }
  }
}
