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
import 'package:easyenglish/core/config/application.dart';
import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/enums/auth_provider_type.dart';
import 'package:easyenglish/core/models/firebase_user.dart';
import 'package:easyenglish/core/models/user.dart';
import 'package:easyenglish/core/services/analytics_service.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/core/services/dialog_service/dialog_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:get_it/get_it.dart';

class DatabaseService {
  static const String TAG = 'FireStoreService';
  final AppStateService _appState;
  final DialogService _dialogService;
  final AnalyticsService _analyticsService = GetIt.I();
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  //region fields
  //common data
  final String _collectionRefCommonData = 'common_data';
  final String _documentRefLoan = 'loan';
  final String _documentRefPhotoShootService = 'photoshoot_service';
  final String _documentRefTraining = 'training';
  final String _documentRefUpgrade = 'upgrade';
  final String _fieldMonths = 'months';
  final String _fieldTypes = 'types';
  final String _fieldRepairWorksDes = 'repair_works_des';

  //users
  final String _collectionRefUsers = '${Application.flavor.name}_users';
  final String _fieldUid = 'uid';
  final String _fieldCreatedAt = 'created_at';
  final String _fieldModifiedAt = 'modified_at';
  static final String fieldMobile = 'mobile';
  static final String fieldMobileUid = 'mobile_uid';
  static final String fieldLastMobileLoggedAt = 'last_mobile_logged_at';
  static final String fieldGoogle = 'google';
  static final String fieldGoogleUid = 'google_uid';
  static final String fieldLastGoogleLoggedAt = 'last_google_logged_at';
  static final String fieldFacebook = 'facebook';
  static final String fieldFacebookUid = 'facebook_uid';
  static final String fieldLastFacebookLoggedAt = 'last_facebook_logged_at';
  static final String fieldApple = 'apple';
  static final String fieldAppleUid = 'apple_uid';
  static final String fieldLastAppleLoggedAt = 'last_apple_logged_at';
  final String _fieldSearchHistory = 'search_history';

  //endregion

  DatabaseService(this._appState, this._dialogService, Settings settings) {
    _instance.settings = settings;
  }

  //region authentication
  ///
  /// validate [user] with [user.providerId] for any confections
  ///
  Future<Map<String, dynamic>> validateUserOnDatabase(
      AppUser user, AuthProvider provider) async {
    Log.d(TAG, 'updateOrCreateUser');

    FirebaseUser? firebaseUser = await _checkAccountExists(provider);

    if (firebaseUser == null) return {'result': true};

    // nothing to cross validate
    if (user.providers == null || user.providers!.isEmpty)
      return {'result': true, 'firebase_user': firebaseUser};

    return _validateAccountAgainstProviders(firebaseUser, user.providers!)
        ? {'result': true, 'firebase_user': firebaseUser}
        : {'result': false};
  }

  bool _validateAccountAgainstProviders(
      FirebaseUser firebaseUser, List<AuthProvider> providers) {
    Log.d(TAG, '${firebaseUser.toJson()}',
        references: ['_validateAccountAgainstProviders']);
    bool result = true;

    for (AuthProvider provider in providers) {
      String? uid;
      String? identifier;

      if (provider.provider == PhoneAuthProvider.PROVIDER_ID) {
        uid = firebaseUser.mobileUid;
        identifier = firebaseUser.mobile;
      } else if (provider.provider == GoogleAuthProvider.PROVIDER_ID) {
        uid = firebaseUser.googleUid;
        identifier = firebaseUser.google;
      } else if (provider.provider == FacebookAuthProvider.PROVIDER_ID) {
        uid = firebaseUser.facebookUid;
        identifier = firebaseUser.facebook;
      } else if (provider.provider == 'apple.com') {
        uid = firebaseUser.appleUid;
        identifier = firebaseUser.apple;
      }

      Log.d(TAG, '$uid : $identifier',
          references: ['_validateAccountAgainstProviders', 'firebaseUser']);
      Log.d(TAG, '${provider.uid} : ${provider.identifier}',
          references: ['_validateAccountAgainstProviders', 'provider']);

      if ((identifier?.isNotEmpty ?? false) &&
          identifier != provider.identifier) {
        result = false;
      }
      if ((uid?.isNotEmpty ?? false) && uid != provider.uid) {
        result = false;
      }

      if (!result) break;
    }

    return result;
  }

  Future<FirebaseUser?> _checkAccountExists(AuthProvider provider) async {
    Log.d(TAG, '${provider.toJson()}', references: ['checkAccountExists']);

    return _instance
        .collection(_collectionRefUsers)
        .where(provider.providerType.fieldIdentifier,
            isEqualTo: provider.identifier)
        .get()
        .then((value) {
      if (value.size > 0) {
        Log.d(TAG, '${value.docs[0].id}', references: ['checkAccountExists']);
        return FirebaseUser.fromJson(value.docs[0].data());
      }
      return null;
    }, onError: (error) => Future.error(error));
  }

  Future<FirebaseUser> _createAccount(AuthProvider provider) async {
    Log.d(TAG, '${provider.toJson()}', references: ['createAccount']);

    final type = provider.providerType;

    Map<String, dynamic> data = {
      type.fieldUid: provider.uid,
      type.fieldIdentifier: provider.identifier,
      _fieldCreatedAt: DateTime.now().toString(),
    };

    var ref = await _instance.collection(_collectionRefUsers).add(data);

    await ref.update({_fieldUid: ref.id});

    var _ref = await ref.get();

    Log.d(TAG, '${_ref.data()}', references: ['createAccount', 'firebaseUser']);
    return FirebaseUser.fromJson(_ref.data()!);
  }

  Future<FirebaseUser> _mergeAccounts(
      AuthProvider from, AuthProvider to) async {
    Log.d(TAG, 'from: ${from.toJson()}\nto: ${to.toJson()}',
        references: ['mergeAccounts']);

    var toAccount = await _checkAccountExists(to);

    if (toAccount == null) toAccount = await _createAccount(to);

    return await _instance
        .collection(_collectionRefUsers)
        .where(to.providerType.fieldIdentifier, isEqualTo: to.identifier)
        .get()
        .then((value) async {
      if (value.size == 1) {
        var ref = value.docs[0].reference;
        await ref.update({
          from.providerType.fieldUid: from.uid,
          from.providerType.fieldIdentifier: from.identifier,
          from.providerType.fieldLastLoggedAt: DateTime.now().toString(),
          _fieldModifiedAt: DateTime.now().toString(),
        });
        var _ref = await ref.get();

        Log.d(TAG, '${_ref.data()}',
            references: ['mergeAccounts', 'firebaseUser']);
        return FirebaseUser.fromJson(_ref.data()!);
      } else {
        return Future.error(ErrorMessages.SOMETHING_WENT_WRONG);
      }
    }, onError: (error) => Future.error(error));
  }

  Future<FirebaseUser> updateOrCreateUser(AppUser user,
      [FirebaseUser? firebaseUser]) async {
    Log.d(TAG, 'updateOrCreateUser');

    if (user.providers?.isNotEmpty ?? false) {
      if (user.providers?.length == 1 && firebaseUser == null) {
        return _createAccount(user.providers![0]);
      } else if (user.providers?.length == 1 && firebaseUser != null) {
        //no need to update information
        //but evaluate further and see on more scenarios
        return firebaseUser;
      } else if ((user.providers?.length ?? 0) > 1 && firebaseUser == null) {
        final primary =
            user.providers?.singleWhere((element) => element.isPrimary);
        final secondary =
            user.providers?.singleWhere((element) => !element.isPrimary);

        if (primary == null || secondary == null)
          return Future.error(ErrorMessages.UNEXPECTED_ERROR_OCCURRED);

        return _mergeAccounts(secondary, primary);
      } else if ((user.providers?.length ?? 0) > 1 && firebaseUser != null) {
        final primary =
            user.providers?.singleWhere((element) => element.isPrimary);
        final secondary =
            user.providers?.singleWhere((element) => !element.isPrimary);

        if (primary == null || secondary == null)
          return Future.error(ErrorMessages.UNEXPECTED_ERROR_OCCURRED);

        return _mergeAccounts(primary, secondary);
      }
    }

    return Future.error(ErrorMessages.UNEXPECTED_ERROR_OCCURRED);
  }

  Future<bool> logLogin(AuthProviderType authProviderType, String uid) async {
    Log.d(TAG, '$authProviderType - $uid', references: ['addUserLoginEvent']);

    return _instance.collection(_collectionRefUsers).doc(uid).get().then(
        (value) async {
      if (value.exists) {
        await value.reference.update({
          authProviderType.fieldLastLoggedAt: DateTime.now().toString(),
        });
        Log.d(TAG, '${value.data()}', references: ['addUserLoginEvent']);
        return true;
      } else {
        return Future.error(ErrorMessages.SOMETHING_WENT_WRONG);
      }
    }, onError: (error) => Future.error(error));
  }

  //endregion

  //region common data

  Future<Map<String, dynamic>?> getCommonDataLoan() async {
    return await _instance
        .collection(_collectionRefCommonData)
        .doc(_documentRefLoan)
        .get()
        .then((value) async {
      if (value.exists) {
        Log.d(TAG, '${value.data()}', references: ['getCommonDataLoan']);
        return value.data();
      }
      return null;
    }, onError: (error) {
      Log.e(TAG, '$error', exception: error, references: ['getCommonDataLoan']);
      return Future.error(error);
    });
  }

  Future<List<String>?> getCommonDataTraining() async {
    return await _instance
        .collection(_collectionRefCommonData)
        .doc(_documentRefTraining)
        .get()
        .then((value) async {
      if (value.exists) {
        Log.d(TAG, '${value.data()}', references: ['getCommonDataTraining']);
        return (value.data()?[_fieldTypes] as List)
            .map((e) => e as String)
            .toList();
      }
      return null;
    }, onError: (error) {
      Log.e(TAG, '$error',
          exception: error, references: ['getCommonDataTraining']);
      return Future.error(error);
    });
  }

  Future<Map<String, dynamic>?> getCommonDataUpgrade() async {
    return await _instance
        .collection(_collectionRefCommonData)
        .doc(_documentRefUpgrade)
        .get()
        .then((value) async {
      if (value.exists) {
        Log.d(TAG, '${value.data()}', references: ['getCommonDataUpgrade']);
        return {
          'des': value.data()?[_fieldRepairWorksDes],
          'types': value.data()?[_fieldTypes],
        };
      }
      return null;
    }, onError: (error) {
      Log.e(TAG, '$error',
          exception: error, references: ['getCommonDataUpgrade']);
      return Future.error(error);
    });
  }

//endregion
}
