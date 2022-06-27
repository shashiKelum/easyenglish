import 'package:rxdart/subjects.dart';

import '../../core/enums/bottom_nav_items.dart';
import '../../core/services/api/api.dart';
import '../../core/services/dialog_service/dialog_service.dart';

class GeneralService {
  final Api _api;
  final DialogService _dialogService;

  GeneralService(this._api, this._dialogService) {}

  BehaviorSubject<BottomNavItems> _currentNavItem =
      BehaviorSubject.seeded(BottomNavItems.Dashboard);

  BehaviorSubject<BottomNavItems> get currentNavItem => _currentNavItem;

  void onChangeNavItem(BottomNavItems item) {
    _currentNavItem.add(item);
  }
}
