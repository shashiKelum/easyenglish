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

import 'package:easyenglish/core/services/media_service.dart';
import 'package:easyenglish/r.g.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends BaseViewModel {
  final MediaService _mediaService;

  final achievements = [
    Achievement(Color(0xFF8CC53E), Color(0xFF6EA130),
        R.svg.ic_achieve_1(width: 40, height: 40)),
    Achievement(Color(0xFF873CC9), Color(0xFF6B26A8),
        R.svg.ic_achieve_2(width: 40, height: 40)),
    Achievement(Color(0xFFEB5851), Color(0xFFD84032),
        R.svg.ic_achieve_3(width: 40, height: 40)),
    Achievement(Color(0xFF2BD1CB), Color(0xFF1A9D98),
        R.svg.ic_achieve_4(width: 40, height: 40)),
    Achievement(Color(0xFF2196F3), Color(0xFF1976D2),
        R.svg.ic_achieve_5(width: 40, height: 40)),
    Achievement(Color(0xFFFD9230), Color(0xFFBB681D),
        R.svg.ic_achieve_6(width: 40, height: 40)),
  ];
  final songss = [
    Reading(Color(0xFFFFDE99), Color(0xFFFFB44B),
        R.svg.ic_song_1(width: 45, height: 45)),
    Reading(Color(0xFFD8F3FE), Color(0xFF26ADE4),
        R.svg.ic_song_2(width: 45, height: 45)),
    Reading(Color(0xFFFF873D), Color(0xFFA45829),
        R.svg.ic_song_3(width: 45, height: 45)),
    Reading(Color(0xFFFFEFBE), Color(0xFFE5CB78),
        R.svg.ic_song_4(width: 45, height: 45)),
    Reading(Color(0xFFEBF7FF), Color(0xFF3397E8),
        R.svg.ic_song_5(width: 45, height: 45)),
  ];

  DashboardViewModel(this._mediaService);

  MediaService get mediaService => _mediaService;

  @override
  void dispose() {
    super.dispose();
  }
}

class Achievement {
  final Color color;
  final Color shadow;
  final ImageProvider image;

  Achievement(this.color, this.shadow, this.image);
}

class Reading {
  final Color color;
  final Color shadow;
  final ImageProvider image;

  Reading(this.color, this.shadow, this.image);
}
