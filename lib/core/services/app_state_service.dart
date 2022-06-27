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

import 'package:easy_localization/src/public_ext.dart';
import 'package:easyenglish/core/enums/account_type.dart';
import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/core/services/secure_store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/enums/auth_state.dart';
import '../../core/models/user.dart';

class AppStateService {
  static const TAG = 'AppStateService';
  final SecureStoreService _storageService;
  AppUser? _mUser;
  AuthState? _mAuthState;
  Locale _locale = Locale('en', 'US');

  BehaviorSubject<AccountType> _accountType =
      BehaviorSubject.seeded(AccountType.Guest);

  BehaviorSubject<AppUser?> _userController = BehaviorSubject();

  BehaviorSubject<AuthState> _authStateController = BehaviorSubject();

  BehaviorSubject<Language> _langController = BehaviorSubject();

  BehaviorSubject<AccountType> get accountType => _accountType;

  BehaviorSubject<AppUser?> get user => _userController;

  BehaviorSubject<AuthState> get authState => _authStateController;

  BehaviorSubject<Language> get language => _langController;

  AuthState? get authStateValue => authState.valueOrNull;

  AppUser? get userValue => user.valueOrNull;

  AccountType? get accountTypeValue => accountType.valueOrNull;

  Locale get locale => _locale;

  AppStateService(this._storageService) {
    getAuthState();
    getLanguage();
  }

  _setAccountType(AppUser? user) {
    if (user == null || user.profile == null) {
      _accountType.add(AccountType.Guest);
    } else {
      _accountType.add((user.profile!.isParent == 1
          ? AccountType.Parent
          : AccountType.Student));
    }
  }

  Future<AppUser?> getUser() async {
    var _user = await _storageService.getUser();
    _setAccountType(_user);
    Log.d(TAG, 'getUser: $_user');
    Log.d(TAG, 'firebaseUser: ${FirebaseAuth.instance.currentUser.toString()}');
    if (_isDiffUser(_user)) _userController.add(_user);
    return _user;
  }

  Future<bool> setUser(AppUser? user) async {
    Log.d(TAG, 'setUser: $user');
    final res = await _storageService.setUser(user);
    _setAccountType(user);
    if (_isDiffUser(user)) _userController.add(user);
    return res;
  }

  Future<AuthState?> getAuthState() async {
    var state = await _storageService.getAuthState();
    Log.d(TAG, '$state', references: ['getAuthState']);
    if (_isDiffState(state)) _authStateController.add(state ?? AuthState.None);
    await getUser();
    return state;
  }

  Future<bool> setAuthState(AuthState state) async {
    Log.d(TAG, '$state', references: ['setAuthState']);
    final res = await _storageService.setAuthState(state);
    if (_isDiffState(state))
      _authStateController.add(res ? state : AuthState.None);
    if (state == AuthState.SignedIn) await getUser();
    return res;
  }

  bool _isDiffUser(AppUser? user) {
    if (_mUser == null) {
      Log.d(TAG, 'AppUser : different');
      _mUser = user == null ? null : AppUser.fromJson(user.toJson());
      return true;
    } else if (_mUser != user) {
      Log.d(TAG, 'AppUser : different');
      _mUser = user == null ? null : AppUser.fromJson(user.toJson());
      return true;
    } else {
      return false;
    }
  }

  bool _isDiffState(AuthState? state) {
    if (_mAuthState == null) {
      Log.d(TAG, 'AuthState : different');
      _mAuthState = state;
      return true;
    } else if (_mAuthState != state) {
      Log.d(TAG, 'AuthState : different');
      _mAuthState = state;
      return true;
    } else {
      Log.d(TAG, 'AuthState : not different');
      return false;
    }
  }

  Future<void> switchLanguage(BuildContext context) async {
    Language language = await getLanguage();
    if(context.locale.languageCode == "en") {
      await context.setLocale(language.locale);
    } else {
      await context.setLocale(Language.English.locale);
    }
  }

  Future<Language> getLanguage() async {
    if (_langController.valueOrNull == null) {
      var lang = await _storageService.getLanguage();
      Log.d(TAG, '$lang', references: ['getLanguage']);
      _langController.add(lang);
      return lang;
    } else {
      return _langController.value;
    }
  }

  void setLanguage(BuildContext context, Language language) {
    _storageService.setLanguage(language);
    _langController.add(language);
  }

  void dispose() async {
    Log.d(TAG, 'disposing');
    // _authStateController.close();
    // _userController.close();
  }
}
