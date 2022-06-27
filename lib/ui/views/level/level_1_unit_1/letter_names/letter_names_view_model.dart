import 'dart:convert';

import 'package:easyenglish/core/models/letters_entity.dart';
import 'package:easyenglish/ui/views/level/level_view_model.dart';
import 'package:easyenglish/ui/widgets/audio_controller/audio_controller_view_model.dart';
import 'package:flutter/services.dart';

class LetterNamesViewModel extends AudioControllerViewModel {
  /// 1 = capital letters
  /// 2 = simple letters
  final int method;
  final LevelViewModel _parentViewModel;

  int _highlightedIndex = -1;
  late List<Letter> _letters;

  LetterNamesViewModel(this._parentViewModel, this.method)
      : super(true, 'assets/raw/level_1_unit_1_1.mp3');

  get cLetters => ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  get sLetters => ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];

  int get highlightedIndex => _highlightedIndex;

  set highlightedIndex(int highlightedIndex) {
    _highlightedIndex = highlightedIndex;
    notifyListeners();
  }

  void init() async {
    final parsed = jsonDecode((await rootBundle.loadString('assets/raw/a_z_letter_duration.json'))).cast<Map<String, dynamic>>();
    _letters = parsed.map<Letter>((json) => Letter.fromJson(json)).toList();

    super.init();
    positionStream.listen((event) => _onChangePosition(event));
  }

  String getLetter(int index) =>
      method == 1 ? cLetters[index] : sLetters[index];

  void onClickNext() => _parentViewModel.onClickNext();

  void _onChangePosition(Duration? position) {
    if (position == null) return;

    for (final Letter letter in _letters) {
      final start = Duration(milliseconds: letter.start);
      final end = Duration(milliseconds: letter.end);

      if (start.inMilliseconds <= position.inMilliseconds &&
          end.inMilliseconds >= position.inMilliseconds) {
        highlightedIndex = letter.index;
        break;
      }
    }
  }
}
