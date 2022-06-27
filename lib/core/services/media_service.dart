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
import 'package:easyenglish/core/models/song_entity.dart';
import 'package:easyenglish/core/services/api/api.dart';
import 'package:easyenglish/core/services/app_state_service.dart';

class MediaService {
  final Api _api;
  final AppStateService _appStateService;

  MediaService(this._api, this._appStateService);

  Future<List<Song>?> getAllSongs() {
    return _api.allSongs().then((value) {
      if (value.status) {
        return value.data?.songs;
      } else {
        return Future.error(
            value.message ?? ErrorMessages.SOMETHING_WENT_WRONG);
      }
    }, onError: (error) => Future.error('$error'));
  }
}
