import 'dart:async';

import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/core/enums/playback_rate.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/core/services/books_service.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FlashcardViewModel extends BaseViewModel {
  final BooksService _booksService;
  final AppStateService _appStateService;
  final NavigationService _navigationService = GetIt.I.get();
  final AudioPlayer _player = AudioPlayer();
  final BehaviorSubject<Term> _controller = BehaviorSubject();
  final List<StreamSubscription> _subscriptions = [];

  late Term _term;
  late Language _language;
  bool _speakerEnabled = true;
  PlaybackRate _playbackRate = PlaybackRate.Normal;

  FlashcardViewModel(this._booksService, this._appStateService, int termId) {
    _appStateService.getLanguage().then((value) => _language = value);

    _subscriptions.add(_player.processingStateStream.listen((event) {
      speakerEnabled =
          event == ProcessingState.ready || event == ProcessingState.completed;
    }));

    getTerm(termId);
  }

  bool get speakerEnabled => _speakerEnabled;

  set speakerEnabled(bool speakerEnabled) {
    _speakerEnabled = speakerEnabled;
    notifyListeners();
  }

  PlaybackRate get playbackRate => _playbackRate;

  set playbackRate(PlaybackRate playbackRate) {
    _playbackRate = playbackRate;
    notifyListeners();
  }

  Language get language => _language;

  Term get term => _term;

  BehaviorSubject<Term> get termStream => _controller;

  void getTerm(int termId) {
    _booksService.getTerm(termId).then((value) async {
      _term = value;
      _controller.add(value);

      if (value.audioPath != null) await _player.setUrl(value.audioPath!);
    }, onError: (error) => _controller.addError(error));
  }

  void onClickBack() => _navigationService.popUntil((route) => route.settings.name == Routes.bookView);

  void onTapSpeaker() async {
    await _player.seek(Duration.zero);
    await _player.play();
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

  @override
  void dispose() async {
    await _player.stop();
    await _player.dispose();
    super.dispose();
  }

  void onTapTerm(int termId) =>
      _navigationService.navigateTo(Routes.flashcardView,
          arguments: FlashcardViewArguments(termId: termId));
}
