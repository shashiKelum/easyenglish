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
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class AudioControllerViewModel extends BaseViewModel {
  final AudioPlayer _player = AudioPlayer();
  final BehaviorSubject<Duration> _audioProgress =
      BehaviorSubject.seeded(Duration());
  final List<StreamSubscription> _subscriptions = [];

  final bool _isAsset;
  final String _audioPath;

  AudioControllerViewModel(this._isAsset, this._audioPath);

  Stream<Duration> get positionStream => _player.positionStream;

  Timer? timer;

  AudioPlayer get player => _player;

  BehaviorSubject<Duration> get audioProgress => _audioProgress;

  int _audioLength = 1;

  int get audioLength => _audioLength;

  set audioLength(int audioLength) {
    _audioLength = audioLength;
    notifyListeners();
  }

  bool _nextButtonEnabled = false;

  bool get nextButtonEnabled => _nextButtonEnabled;

  set nextButtonEnabled(bool nextButtonEnabled) {
    _nextButtonEnabled = nextButtonEnabled;
    notifyListeners();
  }

  PlaybackRate _playbackRate = PlaybackRate.Normal;

  PlaybackRate get playbackRate => _playbackRate;

  set playbackRate(PlaybackRate playbackRate) {
    _playbackRate = playbackRate;
    notifyListeners();
  }

  void init() async {
    // _bookViewModel.pauseAudio.listen((value) async {
    //   if (_player.playerState.playing && value) await _player.pause();
    //   else if (!_player.playerState.playing && !value) await _player.play();
    // });

    if (_isAsset)
      await _player.setAsset(_audioPath);
    else
      await _player.setUrl(_audioPath);

    _player.playbackEventStream.listen((event) {
      audioLength = event.duration?.inMilliseconds ?? 1;
      print('audioLength => $audioLength');
    });

    _player.positionStream.listen((event) {
      _audioProgress.add(event);
    });

    _player.processingStateStream.listen((event) {
      switch (event) {
        case ProcessingState.idle:
          // TODO: Handle this case.
          break;
        case ProcessingState.loading:
          // TODO: Handle this case.
          break;
        case ProcessingState.buffering:
          // TODO: Handle this case.
          break;
        case ProcessingState.ready:
          // TODO: Handle this case.
          break;
        case ProcessingState.completed:
          nextButtonEnabled = true;
          break;
      }
    });

    Future.delayed(Duration(seconds: 2), () async {
      await _player.play();
    });
  }

  void onChangeSlider(double value) async {
    if (_player.playerState.playing) {
      await _player.pause();
    }

    if (timer != null) {
      timer?.cancel();
    }

    final d = Duration(milliseconds: value.toInt());
    _audioProgress.add(d);

    timer = Timer(Duration(milliseconds: 1000), () async {
      _player.seek(d);
      await _player.play();
    });
  }

  @override
  void dispose() async {
    await _player.stop();
    await _player.dispose();
    if (_subscriptions.isNotEmpty)
      _subscriptions.forEach((element) async => await element.cancel());
    super.dispose();
  }

  void onTapSliderThumb() async {
    print('onTapSliderThumb');
    if (_player.playerState.playing) {
      await _player.pause();
    } else {
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
}
