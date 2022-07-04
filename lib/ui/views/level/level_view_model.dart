import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/enums/level_item_state.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/ui/widgets/dummy_view.dart';
import 'package:easyenglish/ui/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'level_1_unit_1/letter_names/letter_names_view.dart';
import 'level_1_unit_1/letter_shapes/letter_shapes_view.dart';
import 'level_1_unit_1/phonic_words/phonic_words_view.dart';

class LevelViewModel extends BaseViewModel {
  final NavigationService _navigationService = GetIt.I.get();
  final AppStateService _appStateService;
  final int level;
  final int unit;
  final PageController controller = PageController();

  List<LevelState> _stateItems = [];

  LevelViewModel(this._appStateService, this.level, this.unit);

  List<LevelState> get stateItems => _stateItems;

  set stateItems(List<LevelState> stateItems) {
    _stateItems = stateItems;
    notifyListeners();
  }

  void init() => generateStateList(0);

  void generateStateList(double page) {
    print('page: $page');
    List<LevelState> states = [];
    for (int i = 0; i < getPageCount(); i++) {
      states.add(i == page
          ? LevelState.Active
          : i < page
              ? LevelState.Complete
              : LevelState.Pending);
    }
    stateItems = states;
  }

  void onTapLanguage(BuildContext context) async {
    //New changes 
    await _appStateService.switchLanguageNew(context);
  }

  void onClickBack() => _navigationService.back();

  int getLevelStateList() {
    if (level == 1 && unit == 1) {
      return 4;
    } else if (level == 1 && unit == 2) {
      return 2;
    } else {
      return 0;
    }
  }

  int getPageCount() {
    if (level == 1 && unit == 1) {
      return 4;
    } else if (level == 1 && unit == 2) {
      return 2;
    } else {
      return 0;
    }
  }

  Widget getPage(BuildContext context, int index) {
    if (level == 1 && unit == 1) {
      switch (index) {
        case 0:
          return LetterNamesView(method: 1);
        case 1:
          return LetterShapesView();
        case 2:
          return LetterNamesView(method: 2);
        case 3:
          return PhonicWordsView();
      }
    } else if (level == 1 && unit == 2) {
      switch (index) {
        case 0:
          return DummyView(name: 'level 2 unit 1');
        case 1:
          return DummyView(name: 'level 2 unit 2');
      }
    }
    return ErrorView(message: ErrorMessages.SOMETHING_WENT_WRONG);
  }

  void onClickNext() {
    if ((controller.page ?? 0) + 1 >= getPageCount()) {
      _navigationService.replaceWith(Routes.levelCompleteView,
          arguments: LevelCompleteViewArguments(level: level, unit: unit));
    } else {
      controller
          .nextPage(duration: Duration(seconds: 1), curve: Curves.easeIn)
          .then((value) => generateStateList(controller.page!));
    }
  }
}
