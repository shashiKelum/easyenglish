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

import 'dart:async';
import 'dart:convert';

import 'package:easyenglish/core/enums/language.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';

import '../../core/enums/auth_state.dart';
import '../../core/models/user.dart';

class SecureStoreService {
  static const TAG = 'SecureStoreService';
  static const String _k_user = 'pref_user';
  static const String _k_auth = 'pref_auth';
  static const String _k_lang = 'pref_lang';
  static const String _k_search = 'pref_search';
  final FlutterSecureStorage _instance;

  SecureStoreService(this._instance);

  Future<AppUser?> getUser() async {
    var _u = await _instance.containsKey(key: _k_user)
        ? await _instance.read(key: _k_user)
        : null;
    try {
      if (_u != null) {
        var u = AppUser.fromJson(json.decode(_u));
        Log.d(TAG, 'getUser: $_u');
        return u;
      }
    } catch (e) {
      Log.e(TAG, 'getUser: $e', exception: e);
    }
    return null;
  }

  Future<bool> setUser(AppUser? user) async {
    try {
      if (user == null) {
        if (await _instance.containsKey(key: _k_user)) {
          await _instance.delete(key: _k_user);
          Log.i(TAG, 'user deleted', references: ['setUser']);
          return true;
        }
      } else {
        await _instance.write(key: _k_user, value: json.encode(user.toJson()));
        Log.i(TAG, 'user updated', references: ['setUser']);
        return true;
      }
    } catch (e) {
      Log.e(TAG, 'setUser: $e', exception: e);
    }
    return false;
  }

  Future<AuthState?> getAuthState() async {
    try {
      var val = await _instance.read(key: _k_auth) ?? AuthState.None.toString();
      AuthState status =
          AuthState.values.firstWhere((e) => e.toString() == val);
      Log.d(TAG, 'getAuthState: $status');
      return status;
    } catch (e) {
      Log.e(TAG, 'getAuthState: $e', exception: e);
      return null;
    }
  }

  Future<bool> setAuthState(AuthState state) async {
    try {
      Log.d(TAG, 'setAuthState: $state');
      await _instance.write(key: _k_auth, value: state.toString());
      return true;
    } catch (e) {
      Log.e(TAG, 'setAuthState: $e', exception: e);
    }

    return false;
  }

  Future<Language> getLanguage() async {
    try {
      var val =
          await _instance.read(key: _k_lang) ?? Language.English.toString();
      Language status = Language.values.firstWhere((e) => e.toString() == val);
      Log.d(TAG, 'getLanguage: $status');
      return status;
    } catch (e) {
      Log.e(TAG, 'getLanguage: $e', exception: e);
      return Language.English;
    }
  }

  void setLanguage(Language language) async {
    try {
      Log.d(TAG, 'setLanguage: $language');
      await _instance.write(key: _k_lang, value: language.toString());
    } catch (e) {
      Log.e(TAG, 'setLanguage: $e', exception: e);
    }
  }
}
