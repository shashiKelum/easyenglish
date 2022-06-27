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

import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/ui/views/game/game/game_view_model.dart';
import 'package:stacked/stacked.dart';

class Game1ViewModel extends BaseViewModel {
  final GameViewModel _parentViewModel;

  Game1Option _game;
  bool _revealAnswer = false;
  int _answer = -1;

  Game1ViewModel(this._parentViewModel, this._game);

  Game1Option get game => _game;

  set game(Game1Option game) {
    _game = game;
    notifyListeners();
  }

  bool get revealAnswer => _revealAnswer;

  set revealAnswer(bool revealAnswer) {
    _revealAnswer = revealAnswer;
    notifyListeners();
  }

  int get answer => _answer;

  set answer(int answer) {
    _answer = answer;
    notifyListeners();
  }

  void onClickClose() {}

  void onClickReveal() => revealAnswer = true;

  void onClickAnswer(int id) {
    if(answer > -1)
      return;

    answer = id;
    revealAnswer = true;

    _parentViewModel.moveToNext(game.id, isCorrect());
  }

  bool isPass(int answerId) {
    return answer > 0 &&
        answer == answerId &&
        game.answer == answerId;
  }

  bool isFail(int answerId) {
    return answer > 0 &&
        answer == answerId &&
        game.answer != answerId;
  }

  bool isCorrect([int? answerId]) {
    return answer > 0 &&
        game.answer == (answerId ?? answer);
  }
}
