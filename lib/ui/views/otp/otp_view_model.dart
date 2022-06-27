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

import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/enums/otp_verification_method.dart';
import 'package:easyenglish/core/models/otp_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rxdart/subjects.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/services/authentication_service.dart';
import '../../../core/services/dialog_service/dialog_service.dart' as ds;
import '../../../core/services/dialog_service/dialogs/dialog_message.dart';

class OtpViewModel extends BaseViewModel {
  final OtpVerificationMethod _verificationMethod;
  final AuthenticationService _authService;
  final ds.DialogService _dialogService;
  final NavigationService _navigationService = GetIt.I.get();
  final OtpDataEntity _data;
  final formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();
  final BehaviorSubject<ErrorAnimationType> errorController = BehaviorSubject();
  final BehaviorSubject<int> _ticksController = BehaviorSubject();

  BehaviorSubject<int> get ticks => _ticksController;

  Timer? _timer;

  String? _pin;

  bool _verified = true;

  bool get verified => _verified;

  set verified(bool verified) {
    _verified = verified;
    notifyListeners();
  }

  OtpViewModel(this._authService, this._dialogService, this._data,
      this._verificationMethod);

  void _startTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }

    if (_timer == null)
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _ticksController.add(timer.tick);
      });
  }

  void onChangePin(String? value) {
    _pin = value;
  }

  @override
  void dispose() {
    // errorController.close();
    super.dispose();
  }

  void onClickVerify() {
    formKey.currentState!.save();

    if (formKey.currentState!.validate()) {
      _authService.verifyLogin(_data.mobile, _pin!).then((value) {
        if (value['result']) {
          verified = true;
        } else {
          _dialogService.message(ErrorMessages.SOMETHING_WENT_WRONG,
              type: DialogType.Error,
              positiveCallback: (val) => _navigationService.back());
        }
      }, onError: (error) {
        if (error['code'] == 'register') {
          _navigationService.navigateTo(Routes.registerView);
        } else {
          _dialogService.message(ErrorMessages.SOMETHING_WENT_WRONG,
              type: DialogType.Error,
              positiveCallback: (val) => _navigationService.back());
        }
      });
    } else {
      errorController.add(ErrorAnimationType.shake);
    }
  }

  void onClickResend() {
    notifyListeners();
    // _verify(_data.mobile, _authService.optVerificationData.resendToken);
  }

  void onClickStart() {
    _navigationService.clearStackAndShow(Routes.mainView);
  }
}
