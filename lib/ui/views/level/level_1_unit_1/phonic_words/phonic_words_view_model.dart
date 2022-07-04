import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/level/level_view_model.dart';
import 'package:flutter/material.dart';
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

  //For changing languages
  Widget book1page4(BuildContext context) {
    String currLocale = Localizations.localeOf(context).toString();
    switch (currLocale) {
      case 'en':
        return getEngBook1Page4(context);
      case 'si':
        return getSiBook1Page4(context);    
    }

    return getEngBook1Page4(context);
  }

  Widget getEngBook1Page4(BuildContext context) {
    return Align( 
      alignment: Alignment.centerLeft,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        children: [
          Text(
            'These are ',
            style:
                AppStyle.text22SB.copyWith(color: AppColors.textPrimary),
          ),
          Text(
            'Phonic Words',
            style: AppStyle.text22SB.copyWith(color: AppColors.primary),
          ),
          Text('.',
              style: AppStyle.text22SB
                  .copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget getSiBook1Page4(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        children: [
          Text(
              'මේවා ',
            style:
                AppStyle.text22SB.copyWith(color: AppColors.textPrimary),
          ),
          Text(
            'Phonic Words ',
            style: AppStyle.text22SB.copyWith(color: AppColors.primary),
          ),
          Text('ලෙස හැඳින්වේ.',
              style: AppStyle.text22SB
                  .copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
