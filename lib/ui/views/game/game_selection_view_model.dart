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

import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/enums/game_type.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/game_selection_data_entity.dart';
import 'package:easyenglish/core/services/games_service.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GameSelectionViewModel extends BaseViewModel {
  static const TAG = 'GameSelectionViewModel';
  final NavigationService _navigationService = GetIt.I.get();
  final GamesService _gamesService;
  final Book _book;
  final BehaviorSubject<List<GameSelectionData>> _dataController =
      BehaviorSubject.seeded([]);

  GameSelectionViewModel(this._book, this._gamesService) {
    _getGameData();
  }

  BehaviorSubject<List<GameSelectionData>> get data => _dataController;

  void onClickBack() {
    _navigationService.back();
  }

  void onClickContinue() {
    _navigationService.back();
  }

  void onClickGame(GameType gameType) {
    _navigationService
        .navigateTo(
      Routes.gameView,
      arguments: GameViewArguments(
        bookId: _book.id,
        bookLevel: _book.level,
        gameType: gameType,
        game: _getGame(gameType),
      ),
    )
        ?.then((value) {
      if (value != null && value is bool && value) {
        _getGameData();
      }
    });
  }

  void _getGameData() {
    _gamesService.getGames(_book.id).then((value) {
      final List<GameSelectionData> res = [];
      res.add(GameSelectionData(GameType.G1, value.g1.completed, _book.level));
      res.add(GameSelectionData(GameType.G2, value.g2.completed, _book.level));
      // res.add(GameSelectionData(GameType.G3, value.g3.completed, _book.level));
      // res.add(GameSelectionData(GameType.G4, value.g4.completed, _book.level));
      _dataController.add(res);
    });
  }

  dynamic _getGame(GameType gameType) {
    switch (gameType) {
      case GameType.G1:
        return _book.games.g1;
      case GameType.G2:
        return _book.games.g2;
      case GameType.G3:
      case GameType.G4:
        return null;
    }
  }
}
