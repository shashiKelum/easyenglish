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

import 'package:easyenglish/core/models/song_entity.dart';
import 'package:easyenglish/core/services/media_service.dart';
import 'package:easyenglish/ui/views/main/dashboard/dashboard_view_model.dart';
import 'package:rxdart/rxdart.dart';

class DashboardSongsViewModel extends DashboardViewModel {
  final BehaviorSubject<List<Song>?> _songs = BehaviorSubject();

  DashboardSongsViewModel(MediaService mediaService) : super(mediaService) {
    _getSongs();
  }

  BehaviorSubject<List<Song>?> get songs => _songs;

  @override
  void dispose() async {
    await songs.close();
    super.dispose();
  }

  void _getSongs() {
    mediaService.getAllSongs().then((value) => _songs.add(value),
        onError: (error) => _songs.addError(error));
  }
}
