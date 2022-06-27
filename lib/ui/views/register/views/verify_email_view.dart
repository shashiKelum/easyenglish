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
import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/register/register_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VerifyEmailView extends ViewModelWidget<RegisterViewModel> {
  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.register_verify_your_account.tr(), style: AppStyle.text30SB),
          SizedBox(height: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.register_an_email_has_been_sent_to.tr(),
                  style: AppStyle.text22M,
                ),
                Text(
                  '${viewModel.emailController.text}',
                  style: AppStyle.text22M.copyWith(color: AppColors.primary),
                ),
                SizedBox(height: 24),
                Text(
                  LocaleKeys.register_please_click_link_to_verify_your_account.tr(),
                  style: AppStyle.text22M,
                ),
                SizedBox(height: 24),
                TextButton(
                  onPressed: () => viewModel.onTapSwitchInput(true),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_rounded,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 8),
                      Text(
                        LocaleKeys.register_use_phone_number_instead.tr(),
                        style: AppStyle.text20SB
                            .copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SpecialButton(
            onPressed: () =>
                viewModel.onClickContinue(RegisterViewRoutes.passwordView),
          ),
        ],
      ),
    );
  }
}
