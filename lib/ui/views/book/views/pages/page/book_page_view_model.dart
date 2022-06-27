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
import 'package:easyenglish/core/services/books_service.dart';
import 'package:easyenglish/ui/views/book/book_view_model.dart';
import 'package:easyenglish/ui/views/book/views/pages/book_pages_view_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class BookPageViewModel extends BaseViewModel {
  final int _index;
  final BookPage _page;
  final BooksService _booksService;
  final BookViewModel _bookViewModel;
  final BookPagesViewModel _pagesViewModel;
  final AudioPlayer _player = AudioPlayer();
  final BehaviorSubject<List<Sentence>> _sentences = BehaviorSubject.seeded([]);
  final BehaviorSubject<Duration> _audioProgress =
      BehaviorSubject.seeded(Duration());
  final List<StreamSubscription> _subscriptions = [];
  final List<Word> _words = [];

  BookPageViewModel(this._index, this._page, this._booksService,
      this._bookViewModel, this._pagesViewModel);

  Timer? timer;

  AudioPlayer get player => _player;

  BookPage get page => _page;

  BehaviorSubject<List<Sentence>> get sentences => _sentences;

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

  int _highlightWordId = 0;

  int get highlightWordId => _highlightWordId;

  set highlightWordId(int highlightWordId) {
    _highlightWordId = highlightWordId;
    notifyListeners();
  }

  void init() async {
    _bookViewModel.pauseAudio.listen((value) async {
      if (_player.playerState.playing && value) await _player.pause();
      else if (!_player.playerState.playing && !value) await _player.play();
    });

    _sentences.add(page.sentences);
    page.sentences.forEach((sentence) => _words.addAll(sentence.words));

    await _player.setUrl(page.audioPath);

    _player.playbackEventStream.listen((event) {
      audioLength = event.duration?.inMilliseconds ?? 1;
      print('audioLength => $audioLength');
    });

    _player.positionStream.listen((event) {
      _audioProgress.add(event);
      _highlightWord(event);
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
          highlightWordId = 0;
          break;
      }
    });

    Future.delayed(Duration(seconds: 2), () async {
      await _player.play();
    });
  }

  void _highlightWord(Duration? position) {
    if (position == null) return;

    for (final word in _words) {
      final start = Duration(milliseconds: word.start);
      final end = Duration(milliseconds: word.end);

      if (start.inMilliseconds <= position.inMilliseconds &&
          end.inMilliseconds >= position.inMilliseconds) {
        highlightWordId = word.id;
        print('highlightWordId => $highlightWordId');
        break;
      }
    }
  }

  void onClickNext() => _pagesViewModel.onClickNext(_index);

  void onChangeSlider(double value) async {
    print(value);
    if(_player.playerState.playing) {
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
    if(_player.playerState.playing) {
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

  void onClickPrevious() => _pagesViewModel.onClickPrevious(_index);

  void onTapTerm(int term) async {
    if (_player.playerState.playing) await _player.pause();
    _pagesViewModel.onTapTerm(term)?.then((value) async {
      if (!_player.playerState.playing) await _player.play();
    });
  }
}
