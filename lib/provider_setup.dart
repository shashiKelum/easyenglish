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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyenglish/core/services/books_service.dart';
import 'package:easyenglish/core/services/database_service.dart';
import 'package:easyenglish/core/services/games_service.dart';
import 'package:easyenglish/core/services/media_service.dart';
import 'package:easyenglish/core/services/secure_store_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/enums/account_type.dart';
import 'core/enums/auth_state.dart';
import 'core/models/user.dart';
import 'core/services/api/api_client.dart';
import 'core/services/api/api_provider.dart';
import 'core/services/app_state_service.dart';
import 'core/services/authentication_service.dart';
import 'core/services/cart_service.dart';
import 'core/services/dialog_service/dialog_service.dart';
import 'core/services/firebase_config.dart';
import 'core/services/general_service.dart';
import 'core/services/messaging_service.dart';
import 'core/services/user_service.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: SecureStoreService(FlutterSecureStorage())),
  Provider.value(value: DialogService()),
  Provider.value(value: FirebaseConfig()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<SecureStoreService, AppStateService>(
    update: (context, pref, state) => AppStateService(pref),
    dispose: (context, service) => service.dispose(),
  ),
  ProxyProvider<AppStateService, ApiClient>(
    update: (context, state, api) => ApiClient(state),
  ),
  ProxyProvider2<ApiClient, AppStateService, ApiProvider>(
    update: (context, client, state, api) => ApiProvider(client),
  ),
  ProxyProvider<AppStateService, MessagingService>(
    update: (context, state, service) => MessagingService(state),
  ),
  ProxyProvider2<AppStateService, DialogService, DatabaseService>(
    update: (context, state, dialog, service) => DatabaseService(
      state,
      dialog,
      Settings(
        persistenceEnabled: false,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      ),
    ),
  ),
  ProxyProvider5<AppStateService, ApiProvider, DatabaseService,
      MessagingService, DialogService, AuthenticationService>(
    update: (context, state, api, store, msg, dialog, service) =>
        AuthenticationService(state, api, store, msg, dialog),
    dispose: (context, service) => service.dispose(),
  ),
  ProxyProvider2<ApiProvider, DialogService, GeneralService>(
    update: (context, api, dialog, service) => GeneralService(api, dialog),
  ),
  ProxyProvider2<AuthenticationService, ApiProvider, CartService>(
    update: (context, auth, repo, service) => CartService(auth, repo),
    dispose: (context, service) => service.dispose(),
  ),
  ProxyProvider2<ApiProvider, AuthenticationService, UserService>(
    update: (context, api, auth, service) => UserService(api, auth),
  ),
  ProxyProvider2<ApiProvider, AppStateService, MediaService>(
    update: (context, api, state, service) => MediaService(api, state),
  ),
  ProxyProvider2<ApiProvider, AppStateService, BooksService>(
    update: (context, api, state, service) => BooksService(api, state),
  ),
  ProxyProvider2<ApiProvider, AppStateService, GamesService>(
    update: (context, api, state, service) => GamesService(api, state),
  ),
//  ProxyProvider2<AuthenticationService, FirebaseCrashlytics, Messaging>(
//    update: (context, auth, crash, messaging) {
//      var msg = Messaging(auth, crash);
//      msg.initialize();
//      return msg;
//    },
//    dispose: (context, messaging) {
//      messaging.dispose();
//    },
//  ),
];

List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<AuthState?>(
    initialData: null,
    create: (context) => Provider.of<AppStateService>(context).authState,
  ),
  StreamProvider<AppUser?>(
    initialData: null,
    create: (context) => Provider.of<AppStateService>(context).user,
  ),
  StreamProvider<AccountType>(
    initialData: AccountType.Guest,
    create: (context) => Provider.of<AppStateService>(context).accountType,
  ),
];
