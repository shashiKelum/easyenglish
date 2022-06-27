import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TimelineViewModel extends BaseViewModel {
  final NavigationService _navigationService = GetIt.I.get();

  void onTapUnit(Map value) {
    int level = value['level']!;
    int unit = value['unit']!;
    _navigationService.navigateTo(Routes.levelView,
        arguments: LevelViewArguments(level: level, unit: unit));
  }
}
