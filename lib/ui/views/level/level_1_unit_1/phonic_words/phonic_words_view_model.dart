import 'package:easyenglish/ui/views/level/level_view_model.dart';
import 'package:stacked/stacked.dart';

class PhonicWordsViewModel extends BaseViewModel {
  final LevelViewModel _parentViewModel;

  int _highlightedIndex = 0;
  bool _nextButtonEnabled = true;

  PhonicWordsViewModel(this._parentViewModel);

  get cLetters => ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  get sLetters => ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];

  int get highlightedIndex => _highlightedIndex;

  set highlightedIndex(int highlightedIndex) {
    _highlightedIndex = highlightedIndex;
    notifyListeners();
  }

  bool get nextButtonEnabled => _nextButtonEnabled;

  set nextButtonEnabled(bool nextButtonEnabled) {
    _nextButtonEnabled = nextButtonEnabled;
    notifyListeners();
  }

  String getLetter(int index) => sLetters[index];

  String getHighlightedLetter() => sLetters[highlightedIndex];

  void onClickNext() => _parentViewModel.onClickNext();

  void onPageChanged(int value) {
    highlightedIndex = value;
  }
}
