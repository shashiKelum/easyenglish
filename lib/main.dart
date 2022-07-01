import 'package:easyenglish/assets/l10n/l10n.dart';
import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/services/analytics_service.dart';
import 'package:easyenglish/provider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'provider_setup.dart';
import 'ui/theme/theme.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child)  {
            final provider = Provider.of<LocaleProvider>(context);
        return MultiProvider(
          providers: providers,
          child: MaterialApp(
            title: 'EasyEnglish',
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
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
          ),
        );
      }
  );
}
