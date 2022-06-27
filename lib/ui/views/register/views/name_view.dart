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
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/register/register_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:stacked/stacked.dart';

class NameView extends ViewModelWidget<RegisterViewModel> {
  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.register_what_is_your_name.tr(), style: AppStyle.text30SB),
          SizedBox(height: 12),
          Expanded(
            child: Form(
              key: viewModel.formKeyName,
              child: TextFormField(
                controller: viewModel.nameController,
                decoration: InputDecoration(hintText: LocaleKeys.register_hint_name.tr()),
                validator: Validators.validateRequired,
                textCapitalization: TextCapitalization.words,
              ),
            ),
          ),
          SpecialButton(
            onPressed: () =>
                viewModel.onClickContinue(RegisterViewRoutes.inputView),
          ),
        ],
      ),
    );
  }
}
