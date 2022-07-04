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
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/login/login_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:easyenglish/ui/widgets/mobile_number_field.dart';
import 'package:easyenglish/ui/widgets/monkey_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginInputView extends ViewModelWidget<LoginViewModel> {
  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Easy English',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: MonkeyWidget(
                        monkey: R.image.img_monkey_7(),
                        text:  AppLocalizations.of(context)!.enter_your_phone_number,
                      ),
                    ),
                    MobileNumberField(
                      controller: viewModel.mobileController,
                      focusNode: viewModel.mobileFocusNode,
                      validator: Validators.validateMobileNumber,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // TextButton(
                //   onPressed: viewModel.onTapSwitchInput,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         viewModel.isEmail
                //             ? Icons.phone_rounded
                //             : Icons.email_rounded,
                //         color: AppColors.primary,
                //       ),
                //       SizedBox(width: 8),
                //       Text(
                //         viewModel.isEmail
                //             ? LocaleKeys.login_use_phone_number_instead
                //             : LocaleKeys.login_use_email_address_instead,
                //         style: AppStyle.text20SB
                //             .copyWith(color: AppColors.primary),
                //       ).tr(),
                //     ],
                //   ),
                // ),
                SizedBox(height: 16),
                SpecialButton(onPressed: viewModel.onClickSignIn),
                SizedBox(height: 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:  AppLocalizations.of(context)!.do_not_have_an_account,
                        style: AppStyle.text18SB,
                      ),
                      TextSpan(
                        text:  AppLocalizations.of(context)!.register,
                        style: AppStyle.text18SB
                            .copyWith(color: AppColors.primary),
                        recognizer: viewModel.onTapSignUp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
