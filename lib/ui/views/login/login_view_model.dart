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
import 'package:easyenglish/core/enums/auth_state.dart';
import 'package:easyenglish/core/enums/otp_verification_method.dart';
import 'package:easyenglish/core/models/otp_data_entity.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/core/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  static const navKey = 102;
  final AppStateService _appStateService;
  final AuthenticationService _authenticationService;
  final NavigationService _navigationService = GetIt.I.get();
  final formKey = GlobalKey<FormState>();
  final onTapSignUp = TapGestureRecognizer();
  final mobileController = TextEditingController();
  final mobileFocusNode = FocusNode();

  LoginViewModel(this._appStateService, this._authenticationService) {
    onTapSignUp.onTap = _onClickSignUp;
  }

  bool _isEmail = false;

  bool get isEmail => _isEmail;

  set isEmail(bool isEmail) {
    _isEmail = isEmail;
    notifyListeners();
  }

  void onClickSignIn() async {
    mobileFocusNode.unfocus();
    formKey.currentState!.save();

    if (formKey.currentState!.validate()) {
      _clearCache();

      _authenticationService.login('+94${mobileController.text}').then((value) {
        _navigationService.navigateTo(
          RegisterViewRoutes.otpView,
          arguments: OtpViewArguments(
            verificationMethod: OtpVerificationMethod.Login,
            data: OtpDataEntity(mobile: '+94${mobileController.text}'),
          ),
          id: navKey,
        );
      });
    }
  }

  void _onClickSignUp() {
    _clearCache();
    _navigationService.navigateTo(Routes.registerView);
  }

  void onTapSwitchInput() {}

  void onClickBack() => _navigationService.back();

  void _clearCache() async {
    await _appStateService.setAuthState(AuthState.None);
    await _appStateService.setUser(null);
  }
}
