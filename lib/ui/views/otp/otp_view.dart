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
import 'package:easyenglish/core/enums/otp_verification_method.dart';
import 'package:easyenglish/core/models/otp_data_entity.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/otp/otp_pin_code_view.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:easyenglish/ui/widgets/monkey_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../ui/views/otp/otp_view_model.dart';

class OtpView extends ViewModelBuilderWidget<OtpViewModel> {
  final OtpVerificationMethod verificationMethod;
  final OtpDataEntity data;

  OtpView(this.verificationMethod, this.data);

  @override
  Widget builder(BuildContext context, OtpViewModel model, Widget? child) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(LocaleKeys.register_verify_your_account.tr(),
                    style: AppStyle.text30SB),
                SizedBox(height: 52),
                Form(
                  key: model.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: OtpPinCodeView(),
                ),
                SizedBox(height: 16),
                // if (!model.verified) OTPWaitingView(),
                if (model.verified)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                          image:
                              R.svg.ic_successful(width: 22.47, height: 20.34)),
                      SizedBox(width: 4),
                      Text(
                        LocaleKeys.register_verification.tr(),
                        style: AppStyle.text20SB
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      Text(
                        LocaleKeys.register_successful.tr(),
                        style: AppStyle.text20SB
                            .copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                if (model.verified) SizedBox(height: 48),
                if (model.verified)
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: MonkeyWidget(
                          monkey: R.image.img_monkey_3(),
                          text: LocaleKeys.register_hooray_lets_start_learning
                              .tr(),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (!model.verified)
            SpecialButton(
              onPressed: model.onClickVerify,
            ),
          if (model.verified)
            SpecialButton(
              text: LocaleKeys.button_start_learning.tr(),
              onPressed: model.onClickStart,
            )
        ],
      ),
    );
  }

  @override
  OtpViewModel viewModelBuilder(BuildContext context) => OtpViewModel(
      Provider.of(context), Provider.of(context), data, verificationMethod);

// @override
// void onViewModelReady(OtpViewModel model) =>
//     Future.delayed(Duration(milliseconds: 300), () => model.init());
}
