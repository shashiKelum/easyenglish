import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/services/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'provider_setup.dart';
import 'ui/theme/theme.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'SalonWorld',
        theme: AppTheme.theme,
        // navigatorKey: GetIt.I<NavigationService>().navigatorKey,
        // onGenerateRoute: StackedRouter().onGenerateRoute,
        // navigatorObservers: [
        //   GetIt.I<AnalyticsService>().getAnalyticsObserver()
        // ],
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorObservers: [
          GetIt.I<AnalyticsService>().getAnalyticsObserver()
        ],
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
