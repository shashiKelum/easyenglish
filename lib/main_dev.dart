import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/config/application.dart';
import 'main.dart';

void main() async {
  await Application.init(Flavor.DEV);

  if (kDebugMode)
    runApp( 
      EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('si', 'SL'),
          Locale('ta', 'SL'),
        ],
        path: 'lib/assets/langs',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp(),
      ),
    );
  else
    runZonedGuarded(() {
      runApp(
        EasyLocalization(
          supportedLocales: [
            Locale('en', 'US'),
            Locale('si', 'SL'),
            Locale('ta', 'SL'),
          ],
          path: 'lib/assets/langs',
          fallbackLocale: Locale('en', 'US'),
          child: MyApp(),
        ),
      );
    }, FirebaseCrashlytics.instance.recordError);
}
