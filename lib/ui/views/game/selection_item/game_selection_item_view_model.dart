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

import 'package:easyenglish/core/enums/game_type.dart';
import 'package:easyenglish/core/models/game_selection_data_entity.dart';
import 'package:stacked/stacked.dart';

class GameSelectionItemViewModel extends BaseViewModel {
  final int index;
  final GameSelectionData data;
  late final GameType _gameType;

  GameSelectionItemViewModel(this.index, this.data) {
    _gameType = GameType.values[index];
  }

  GameType get gameType => _gameType;

  int getProgress(int progress) {
    return (progress / 10 * 100).toInt();
  }
}
