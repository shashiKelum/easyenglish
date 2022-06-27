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
import 'package:easyenglish/core/enums/game_item_state.dart';
import 'package:easyenglish/core/enums/game_type.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/game_entity.dart';
import 'package:easyenglish/core/services/games_service.dart';
import 'package:easyenglish/ui/views/game/game1/game1_view.dart';
import 'package:easyenglish/ui/views/game/game2/game2_view.dart';
import 'package:easyenglish/ui/widgets/dummy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GameViewModel extends BaseViewModel {
  static const navKey = 105;
  final NavigationService _navigationService = GetIt.I.get();
  final GamesService _gamesService;
  final int _bookId;
  final int _bookLevel;
  final GameType _gameType;
  final PageController controller = PageController();
  final dynamic _game;
  late List<dynamic> _items;
  int _completedItems = 0;
  int _successCount = 0;

  GameViewModel(this._gamesService, this._bookId, this._bookLevel,
      this._gameType, this._game) {
    _items = getGameOptions();
  }

  int get bookId => _bookId;

  List<dynamic> get items => _items;

  set items(List<dynamic> items) {
    _items = items;
    notifyListeners();
  }

  int get completedItems => _completedItems;

  set completedItems(int completedItems) {
    _completedItems = completedItems;
    notifyListeners();
  }

  int get successCount => _successCount;

  set successCount(int successCount) {
    _successCount = successCount;
    notifyListeners();
  }

  void init() {
    _setCurrentItem();
  }

  void _setCurrentItem([GameState? state]) {
    if (state != null && state == GameState.Pass) successCount += 1;

    GameBaseOption _item = items[completedItems];
    _item.gameItemState = state ?? GameState.Current;
    items[completedItems] = _item;
    notifyListeners();

    if (completedItems + 1 < items.length) {
      for (String url in getGamePageImageUrls(completedItems + 1)) {
        DefaultCacheManager().downloadFile(url);
      }
    }
  }

  void onClickClose() {}

  getGame(dynamic game) {
    switch (_gameType) {
      case GameType.G1:
        return game as Game1;
      case GameType.G2:
        return game as Game2;
      case GameType.G3:
        return game as Game3;
      case GameType.G4:
        return game as Game4;
    }
  }

  List<dynamic> getGameOptions() {
    switch (_gameType) {
      case GameType.G1:
        return (_game as Game1).games;
      case GameType.G2:
        return (_game as Game2).games;
      case GameType.G3:
        return (_game as Game3).games;
      case GameType.G4:
        return (_game as Game4).games;
    }
  }

  void moveToNext(int gameId, bool correct) {
    _gamesService.activityUpdate(bookId, gameId, _gameType);

    _setCurrentItem(correct ? GameState.Pass : GameState.Fail);

    Future.delayed(Duration(seconds: 1), () {
      completedItems += 1;
      if (completedItems < _items.length) {
        _setCurrentItem();
        controller.animateToPage(completedItems,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        _navigationService
            .navigateTo(Routes.gameCompleteView,
                arguments: GameCompleteViewArguments(
                    title: 'Game',
                    buttonText: 'Play Another Game',
                    level: _bookLevel))
            ?.then((value) => _navigationService.back(result: value));
      }
    });
  }

  getGamePage(BuildContext context, int index) {
    switch (_gameType) {
      case GameType.G1:
        return Game1View(_items[index]);
      case GameType.G2:
        return Game2View(_items[index]);
      case GameType.G3:
        return DummyView(name: '$index');
      case GameType.G4:
        return DummyView(name: '$index');
    }
  }

  List<String> getGamePageImageUrls(int index) {
    switch (_gameType) {
      case GameType.G1:
        Game1Option op = _items[index];
        return [op.image1, op.image2, op.image3, op.image4];
      case GameType.G2:
        Game2Option op = _items[index];
        return [op.image1, op.image2, op.image3, op.image4];
      case GameType.G3:
        return [];
      case GameType.G4:
        return [];
    }
  }
}
