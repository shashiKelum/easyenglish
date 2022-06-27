import 'dart:async';

import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/core/enums/playback_rate.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PreludeViewModel extends BaseViewModel {
  final AppStateService _appStateService;
  final NavigationService _navigationService = GetIt.I.get();
  final AudioPlayer _player = AudioPlayer();
  final List<StreamSubscription> _subscriptions = [];
  final Term _term;

  Language _language = Language.English;
  bool _speakerEnabled = true;
  PlaybackRate _playbackRate = PlaybackRate.Normal;

  PreludeViewModel(this._appStateService, this._term) {
    _appStateService.getLanguage().then((value) => language = value);

    _subscriptions.add(_player.processingStateStream.listen((event) {
      speakerEnabled =
          event == ProcessingState.ready || event == ProcessingState.completed;
    }));
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

  set language(Language language) {
    _language = language;
    notifyListeners();
  }

  Term get term => _term;

  void init() async {
    if (_term.audioClip != null) await _player.setUrl(_term.audioClip!);
  }

  void onClickBack() => _navigationService
      .popUntil((route) => route.settings.name == Routes.bookView);

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
}
