import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/enums/account_type.dart';
import 'package:easyenglish/core/enums/bottom_nav_items.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/core/services/authentication_service.dart';
import 'package:easyenglish/core/services/dialog_service/dialog_service.dart';
import 'package:easyenglish/ui/widgets/bottom_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as ss;

class MainViewModel extends BaseViewModel {
  static const TAG = 'MainViewModel';
  final AppStateService _appStateService;
  final AuthenticationService _authService;
  final DialogService _dialogService;
  final ss.NavigationService _navigationService = GetIt.I.get();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  MainViewModel(this._appStateService, this._authService, this._dialogService) {
    _getBottomNav();
  }

  late List<Widget> _bottomNavItems = [];

  List<Widget> get bottomNavItems => _bottomNavItems;

  set bottomNavItems(List<Widget> bottomNavItems) {
    _bottomNavItems = bottomNavItems;
    notifyListeners();
  }

  BottomNavItems _currentNavItem = BottomNavItems.Dashboard;

  BottomNavItems get currentNavItem => _currentNavItem;

  set currentNavItem(BottomNavItems currentNavItem) {
    _currentNavItem = currentNavItem;
    notifyListeners();
  }

  String _title = '';

  String get title => _title;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  AccountType? get accountType => _appStateService.accountTypeValue;

  void _getBottomNav() {
    Log.d(TAG, '$accountType', references: ['_getBottomNav']);

    // final dynamicView =
    //     accountType == AccountType.Salon || accountType == AccountType.Customer
    //         ? BottomNavButton(item: BottomNavItems.Appointments)
    //         : BottomNavButton(item: BottomNavItems.Training);

    bottomNavItems = [
      BottomNavButton(item: BottomNavItems.Account),
      BottomNavButton(item: BottomNavItems.Books),
      BottomNavButton(item: BottomNavItems.Dashboard),
      BottomNavButton(item: BottomNavItems.Music),
      BottomNavButton(item: BottomNavItems.Settings),
    ];
  }

  onClickBottomNavItem(BottomNavItems item) async {
    currentNavItem = item;
    switch (currentNavItem) {
      case BottomNavItems.Account:
      case BottomNavItems.Books:
      case BottomNavItems.Music:
      case BottomNavItems.Settings:
        _navigationService.navigateTo(currentNavItem.route,
            arguments: DummyViewArguments(name: 'Coming Soon...!'), id: 1);
        break;
      case BottomNavItems.Dashboard:
        _navigationService.navigateTo(currentNavItem.route, id: 1);
        break;
    }
  }

  Future<bool> onWillPop() async {
    if (currentNavItem == BottomNavItems.Dashboard)
      return true;
    else {
      onClickBottomNavItem(BottomNavItems.Dashboard);
      return false;
    }
  } 

  void onClickBack() {
    _navigationService.back();
  }

  void onTapLanguage(BuildContext context) async {
    //New changes
    await _appStateService.switchLanguageNew(context);
  }
}
