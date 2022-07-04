import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/level/level_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LetterShapesViewModel extends BaseViewModel {
  final LevelViewModel _parentViewModel;

  int _highlightedIndex = 0;
  bool _nextButtonEnabled = true;

  LetterShapesViewModel(this._parentViewModel);

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

  String getLetter(int index) => cLetters[index];

  String getHighlightedLetter() => cLetters[highlightedIndex];

  void onClickNext() => _parentViewModel.onClickNext();

  void onPageChanged(int value) {
    highlightedIndex = value;
  }

  //For changing languages
  Widget book1page2(BuildContext context) {
    String currLocale = Localizations.localeOf(context).toString();
    switch (currLocale) {
      case 'en':
        return getEngBook1Page2(context);
      case 'si':
        return getSiBook1Page2(context);    
    }

    return getEngBook1Page2(context);
  }

  Widget getEngBook1Page2(BuildContext context) {
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
            'Simple & Capital Letters',
            style: AppStyle.text22SB.copyWith(color: AppColors.primary),
          ),
          Text('.',
              style: AppStyle.text22SB
                  .copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget getSiBook1Page2(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        children: [
          Text(
            'මෙහි දැක්වෙන්නේ ',
            style:
                AppStyle.text22SB.copyWith(color: AppColors.textPrimary),
          ),
          Text(
            'Simple සහ Capital අකුරුය.',
            style: AppStyle.text22SB.copyWith(color: AppColors.primary),
          ),          
        ],
      ),
    );
  }
}
