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
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/register/register_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PasswordView extends ViewModelWidget<RegisterViewModel> {
  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.set_a_password, style: AppStyle.text30SB),
          SizedBox(height: 12),
          Expanded(
            child: Form(
              key: viewModel.formKeyInputPassword,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: viewModel.passwordController,
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.enter_password),
                    validator: Validators.validateRequired,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Text(
                      AppLocalizations.of(context)!.password_strength,
                      style: AppStyle.text12M,
                    ),
                  ),
                  TextFormField(
                    controller: viewModel.cPasswordController,
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.re_enter_password),
                    validator: (value) => Validators.validateConfirmPassword(
                        value, viewModel.passwordController.text),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
          SpecialButton(
            onPressed: () => viewModel.onClickSignUp(),
          ),
        ],
      ),
    );
  }
}
