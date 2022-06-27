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

import 'dart:async';

import 'package:easyenglish/core/enums/playback_rate.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/ui/views/game/game/game_view_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

class Game2ViewModel extends BaseViewModel {
  final GameViewModel _parentViewModel;
  final AudioPlayer _player = AudioPlayer();
  final List<StreamSubscription> _subscriptions = [];

  Game2ViewModel(this._parentViewModel, this._game);

  int get _bookId => _parentViewModel.bookId;

  Game2Option _game;

  Game2Option get game => _game;

  set game(Game2Option game) {
    _game = game;
    notifyListeners();
  }

  bool _revealAnswer = false;

  bool get revealAnswer => _revealAnswer;

  set revealAnswer(bool revealAnswer) {
    _revealAnswer = revealAnswer;
    notifyListeners();
  }

  int _answer = -1;

  int get answer => _answer;

  set answer(int answer) {
    _answer = answer;
    notifyListeners();
  }

  bool _speakerEnabled = false;

  bool get speakerEnabled => _speakerEnabled;

  set speakerEnabled(bool speakerEnabled) {
    _speakerEnabled = speakerEnabled;
    notifyListeners();
  }

  PlaybackRate _playbackRate = PlaybackRate.Normal;

  PlaybackRate get playbackRate => _playbackRate;

  set playbackRate(PlaybackRate playbackRate) {
    _playbackRate = playbackRate;
    notifyListeners();
  }

  void init() async {
    await _player.setUrl(await _getAudioPath());

    _subscriptions.add(_player.processingStateStream.listen((event) {
      speakerEnabled = event == ProcessingState.completed;
    }));

    Future.delayed(Duration(seconds: 2), () async {
      if (!revealAnswer) await _player.play();
    });
  }

  void onClickClose() {}

  void onClickReveal() => revealAnswer = true;

  void onClickAnswer(int id) {
    if (answer > -1) return;

    answer = id;
    revealAnswer = true;

    _player.stop();
    _parentViewModel.moveToNext(game.id, isCorrect());
  }

  bool isPass(int answerId) {
    return answer > 0 && answer == answerId && game.answer == answerId;
  }

  bool isFail(int answerId) {
    return answer > 0 && answer == answerId && game.answer != answerId;
  }

  bool isCorrect([int? answerId]) {
    return answer > 0 && game.answer == (answerId ?? answer);
  }

  void onTapSpeaker() async {
    if (_player.processingState == ProcessingState.completed) {
      await _player.seek(Duration.zero);
      await _player.play();
    }
  }

  void onTapSpeed() {
    switch (playbackRate) {
      case PlaybackRate.Normal:
        playbackRate = PlaybackRate.Slow;
        break;
      case PlaybackRate.Slow:
        playbackRate = PlaybackRate.Slower;
        break;
      case PlaybackRate.Slower:
        playbackRate = PlaybackRate.Normal;
        break;
    }

    _player.setSpeed(playbackRate.rate);
    _player.play();
  }

  Future<String> _getAudioPath() async {
    if (game.audioPath != null) return game.audioPath!;

    final root = await getApplicationSupportDirectory();
    final audioFilePath =
        game.audioPath = '${root.path}/$_bookId/g2/${game.id}/audio.aac';

    return audioFilePath;
  }

  @override
  void dispose() async {
    await _player.stop();
    await _player.dispose();
    super.dispose();
  }
}
