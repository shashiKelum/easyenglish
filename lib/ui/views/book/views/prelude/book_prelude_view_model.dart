import 'package:easyenglish/core/models/term_entity.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../book_view_model.dart';

class BookPreludeViewModel extends BaseViewModel {
  final BookViewModel _parentViewModel;
  final List<Term> _preludes;
  final PageController itemPageController = PageController();
  final PageController pageController = PageController(viewportFraction: 0.2);

  int _index = 0;

  bool _nextButtonEnabled = false;

  BookPreludeViewModel(this._preludes, this._parentViewModel);

  List<Term> get preludes => _preludes;

  int get index => _index;

  set index(int index) {
    _index = index;
    notifyListeners();

    nextButtonEnabled = _index +1 == preludes.length;
  }

  bool get nextButtonEnabled => _nextButtonEnabled;

  set nextButtonEnabled(bool nextButtonEnabled) {
    _nextButtonEnabled = nextButtonEnabled;
    notifyListeners();
  }

  Term get prelude => _preludes[index];

  void onPageChanged(int value) {
    index = value;
    itemPageController.animateToPage(index, duration: Duration(seconds: 1), curve: Curves.easeOut);
  }

  onTapItem(int index) {
    pageController.animateToPage(index, duration: Duration(seconds: 1), curve: Curves.easeOut);
  }

  void onClickNext() => _parentViewModel.onTapPreludeNext();
}
