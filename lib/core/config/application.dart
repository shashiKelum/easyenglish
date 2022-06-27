/*
 * Copyright 2021 CeylonCodeLabs. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */ 

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/services/analytics_service.dart';
import '../../locator.dart';

class Application {
  static const TAG = 'Application';
  static late Flavor flavor;
  static final String appName = 'Easy English';
  static late String baseUrl;
  static late String? encAlgorithm;
  static late String encKey;
  static late String imageBaseUrl;
  static late String? authKey;
  static bool authHeader = false;
  static bool authBody = false;

  static Future<void> init(Flavor _flavor) async {
    flavor = _flavor;
    authHeader = true;
    authBody = false;

    switch (flavor) {
      case Flavor.DEV:
        baseUrl = 'http://54.169.144.237/easyenglish/public/';
        encKey = '7#6s5S\$Esb9M3v43';
        encAlgorithm = 'HmacSHA1';
        imageBaseUrl = 'http://salon-world.syncbridge.net/';
        authKey = 'd742f4dc-425d-45ff-bd9d-06134940f559';
        break;
      case Flavor.TST:
        baseUrl = 'http://54.169.144.237/easyenglish/public/';
        encKey = '7#6s5S\$Esb9M3v43';
        encAlgorithm = 'HmacSHA1';
        imageBaseUrl = 'http://salon-world.syncbridge.net/';
        authKey = 'd742f4dc-425d-45ff-bd9d-06134940f559';
        break;
      case Flavor.PROD:
        baseUrl = 'http://54.169.144.237/easyenglish/public/';
        encKey = '7#6s5S\$Esb9M3v43';
        encAlgorithm = 'HmacSHA1';
        imageBaseUrl = 'http://salon-world.syncbridge.net/';
        authKey = 'd742f4dc-425d-45ff-bd9d-06134940f559';
        break;
    }

    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    Log.init(logInDebugMode: kDebugMode, logInReleaseMode: kReleaseMode);
    Currency.init(name: 'LK ', symbol: 'LKR ', decimalDigits: 0);

    Function? originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError!(errorDetails);
    };

    setupLocator();

    GetIt.I<NavigationService>()
        .config(enableLog: true, defaultTransition: NavigationTransition.Fade);
    await GetIt.I<AnalyticsService>().instance.logAppOpen();
  }
}

enum Flavor { PROD, TST, DEV }

extension FlavorExtension on Flavor {
  String get name {
    switch (this) {
      case Flavor.PROD:
        return 'prod';
      case Flavor.TST:
        return 'test';
      case Flavor.DEV:
        return 'dev';
      default:
        return 'unknown';
    }
  }
}
