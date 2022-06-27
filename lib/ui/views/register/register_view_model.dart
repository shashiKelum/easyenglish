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

import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/enums/account_type.dart';
import 'package:easyenglish/core/enums/auth_provider_type.dart';
import 'package:easyenglish/core/enums/otp_verification_method.dart';
import 'package:easyenglish/core/models/otp_data_entity.dart';
import 'package:easyenglish/core/services/authentication_service.dart';
import 'package:easyenglish/core/services/dialog_service/dialog_service.dart'
    as ds;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  static const navKey = 101;
  final AuthenticationService _authService;
  final ds.DialogService _dialogService;
  final NavigationService _navigationService = GetIt.I.get();
  final formKeyName = GlobalKey<FormState>();
  final formKeyInputPhone = GlobalKey<FormState>();
  final formKeyInputEmail = GlobalKey<FormState>();
  final formKeyInputPassword = GlobalKey<FormState>();
  final onTapSignIn = TapGestureRecognizer();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  RegisterViewModel(this._authService, this._dialogService) {
    onTapSignIn.onTap = _onClickSignIn;
  }

  bool _isEmail = false;

  AccountType _accountType = AccountType.Parent;

  AccountType get accountType => _accountType;

  set accountType(AccountType accountType) {
    _accountType = accountType;
    notifyListeners();
  }

  String? _initialMobile;

  String? get initialMobile => _initialMobile;

  set initialMobile(String? initialMobile) {
    _initialMobile = initialMobile;
    notifyListeners();
  }

  String? _initialEmail;

  String? get initialEmail => _initialEmail;

  set initialEmail(String? initialEmail) {
    _initialEmail = initialEmail;
    notifyListeners();
  }

  String? _initialName;

  String? get initialName => _initialName;

  set initialName(String? initialName) {
    _initialName = initialName;
    notifyListeners();
  }

  void getProviderAccount() async {
    var user = await _authService.getUser();

    if (user?.providers?.isNotEmpty ?? false) {
      for (var provider in user!.providers!) {
        switch (provider.providerType) {
          case AuthProviderType.Phone:
            initialMobile = provider.identifier;
            break;
          case AuthProviderType.Google:
          case AuthProviderType.Facebook:
          case AuthProviderType.Apple:
            initialEmail = provider.identifier;
            initialName = provider.name;
            break;
        }
      }
    }
  }

  void onTapAccountType(AccountType type) => accountType = type;

  void _onClickSignIn() => _navigationService.back();

  void onClickSignUp() async {
    if (_accountType == AccountType.Guest) {
      setError('Please select your account type');
      return;
    } else {
      setError(null);
    }

    if (_isEmail) {
      if (!(formKeyInputPassword.currentState?.validate() ?? false)) return;
    }

    // formKey.currentState!.save();
    //
    // if (formKey.currentState!.validate()) {
    //   setBusy(true);
    //   _authService
    //       .authenticate(
    //           authProviderType: AuthProviderType.Phone, identifier: _mobile!)
    //       .then(
    //     (value) {
    //       _authService
    //           .register(_name!, _email!, _mobile!, _accountType, 'M')
    //           .then((value) {
    //         // _navigationService.popUntil((route) =>
    //         //     (route.settings.name != Routes.registerView &&
    //         //         route.settings.name != Routes.otpView &&
    //         //         route.settings.name != Routes.loginView));
    //         _navigationService.clearStackAndShow(Routes.mainView);
    //       },
    //               onError: (error) => _dialogService.message(error,
    //                   type: DialogType.Error)).whenComplete(() {
    //         setBusy(false);
    //       });
    //     },
    //     onError: (error) {
    //       if (error is AssertionError) {
    //         _dialogService.message(error.message as String,
    //             type: DialogType.Error);
    //       } else {
    //         _dialogService.message(error, type: DialogType.Error);
    //       }
    //     },
    //   ).whenComplete(() {
    //     setBusy(false);
    //   });
    // }
  }

  void onClickBack() {
    _navigationService.back();
  }

  void onClickContinue(String route, [bool? isEmail]) {
    switch (route) {
      case RegisterViewRoutes.inputView:
        if ((formKeyName.currentState?.validate() ?? false)) {
          _navigationService.navigateTo(route,
              arguments: InputViewArguments(isEmail: _isEmail), id: navKey);
        }
        return;
      case 'verify':
        if (isEmail != null) {
          _isEmail = isEmail;
          if (_isEmail) {
            _navigationService.navigateTo(RegisterViewRoutes.verifyEmailView,
                id: navKey);
          } else {
            _navigationService.navigateTo(RegisterViewRoutes.otpView,
                arguments: OtpViewArguments(
                  verificationMethod: OtpVerificationMethod.Register,
                  data: OtpDataEntity(
                    mobile: '+94${mobileController.text}',
                    data: {
                      'is_parent': accountType.value,
                      'name': nameController.text,
                    },
                  ),
                ),
                id: navKey);
          }
          return;
        }        
        break;
    }

    _navigationService.navigateTo(route, id: navKey);
  }

  void onTapSwitchInput(bool isEmail) {
    _navigationService.replaceWith(RegisterViewRoutes.inputView,
        arguments: InputViewArguments(isEmail: !isEmail), id: navKey);
  }
}
