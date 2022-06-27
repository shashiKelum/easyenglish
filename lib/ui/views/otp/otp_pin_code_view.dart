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

import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/views/otp/otp_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

class OtpPinCodeView extends ViewModelWidget<OtpViewModel> {
  final bool isEnabled;

  OtpPinCodeView({Key? key, this.isEnabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context, OtpViewModel viewModel) {
    print('isEnabled: $isEnabled');
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      validator: Validators.validatePinCode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      backgroundColor: Colors.transparent,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1.0,
        inactiveColor: AppColors.primary,
        // activeColor: AppColors.green,
        // selectedColor: AppColors.blue,
      ),
      animationDuration: Duration(milliseconds: 300),
      errorTextSpace: 36.0,
      errorAnimationController: viewModel.errorController,
      controller: viewModel.textEditingController,
      onChanged: (value) => viewModel.onChangePin(value),
      onSaved: (v) => viewModel.onChangePin(v),
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      enabled: isEnabled,
    );
  }
}
