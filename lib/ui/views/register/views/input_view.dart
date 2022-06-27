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
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/register/register_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:easyenglish/ui/widgets/mobile_number_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:stacked/stacked.dart';

class InputView extends ViewModelWidget<RegisterViewModel> {
  final bool isEmail;

  const InputView({required this.isEmail});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.register_verify_your_account.tr(),
              style: AppStyle.text30SB),
          SizedBox(height: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: isEmail
                      ? viewModel.formKeyInputEmail
                      : viewModel.formKeyInputPhone,
                  child: isEmail
                      ? TextFormField(
                          controller: viewModel.emailController,
                          decoration: InputDecoration(
                              hintText:
                                  LocaleKeys.register_enter_email_address.tr()),
                          validator: Validators.validateRequired,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                        )
                      : MobileNumberField(
                          controller: viewModel.mobileController,
                          validator: Validators.validateMobileNumber,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  child: Text(
                    isEmail
                        ? LocaleKeys.register_you_will_need_to_verify_email
                        : LocaleKeys.register_you_will_need_to_verify_phone,
                    style: AppStyle.text12M,
                  ).tr(),
                ),
                TextButton(
                  onPressed: () => viewModel.onTapSwitchInput(isEmail),
                  child: Row(
                    children: [
                      Icon(
                        isEmail ? Icons.phone_rounded : Icons.email_rounded,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 8),
                      Text(
                        isEmail
                            ? LocaleKeys.register_use_phone_number_instead
                            : LocaleKeys.register_use_email_address_instead,
                        style: AppStyle.text20SB
                            .copyWith(color: AppColors.primary),
                      ).tr(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SpecialButton(
            onPressed: () => viewModel.onClickContinue('verify', isEmail),
          ),
        ],
      ),
    );
  }
}
