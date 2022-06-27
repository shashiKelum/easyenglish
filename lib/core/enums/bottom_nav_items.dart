import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/r.g.dart';
import 'package:flutter/material.dart';

enum BottomNavItems { Account, Books, Dashboard, Music, Settings }

extension ExtensionBottomNavItems on BottomNavItems {
  ImageProvider? get icon {
    switch (this) {
      case BottomNavItems.Account:
        return R.svg.ic_boy(width: 20.28, height: 30);
      case BottomNavItems.Books:
        return R.svg.ic_book(width: 24, height: 30);
      case BottomNavItems.Dashboard:
        return R.svg.ic_home(width: 30, height: 30);
      case BottomNavItems.Music:
        return R.svg.ic_music(width: 29.94, height: 30);
      case BottomNavItems.Settings:
        return R.svg.ic_settings(width: 27.9, height: 30);
      default:
        return null;
    }
  }

  // Widget get page {
  //   switch (this) {
  //     case BottomNavItems.Account:
  //       return DummyView(name: 'account');
  //     case BottomNavItems.Books:
  //       return DummyView(name: 'books');
  //     case BottomNavItems.Dashboard:
  //       return DashboardView();
  //     case BottomNavItems.Music:
  //       return DummyView(name: 'music');
  //     case BottomNavItems.Settings:
  //       return DummyView(name: 'settings');
  //     default:
  //       return ErrorView(message: ErrorMessages.SOMETHING_WENT_WRONG);
  //   }
  // }

  String get route {
    switch (this) {
      case BottomNavItems.Account:
        return MainViewRoutes.dummyView;
      case BottomNavItems.Books:
        return MainViewRoutes.dummyView;
      case BottomNavItems.Dashboard:
        return MainViewRoutes.dashboardView;
      case BottomNavItems.Music:
        return MainViewRoutes.dummyView;
      case BottomNavItems.Settings:
        return MainViewRoutes.dummyView;
    }
  }
}
