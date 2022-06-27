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


import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/enums/game_type.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/services/api/api.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:rxdart/rxdart.dart';

class GamesService {
  final Api _api;
  final AppStateService _appStateService;
  final BehaviorSubject<double> _downloadProgress = BehaviorSubject.seeded(0);

  GamesService(this._api, this._appStateService);

  BehaviorSubject<double> get downloadProgress => _downloadProgress;

  Future<BookGames> getGames(int bookId) {
    return _api.games(id: bookId).then((value) async {
      if (value.status) {
        if (value.data != null) {
          return value.data!.games;
        } else
          return Future.error('Book games data not available');
      } else {
        return Future.error(
            value.message ?? ErrorMessages.SOMETHING_WENT_WRONG);
      }
    }, onError: (error) => Future.error('$error'));
  }

  void activityUpdate(int bookId, int gameId, GameType type) {
    _api.gameActivity(bookId: bookId, gameId: gameId, type: type);
  }
}
