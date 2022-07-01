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
import 'package:easyenglish/core/enums/account_type.dart';
import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/register/register_view_model.dart';
import 'package:easyenglish/ui/widgets/account_type_widget.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:easyenglish/ui/widgets/monkey_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AccountSelectionView extends ViewModelWidget<RegisterViewModel> {
  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.who_are_you, style: AppStyle.text30SB),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(width: 6),
              Expanded(
                child: AccountTypeWidget(
                  accountType: AccountType.Parent,
                  selected: viewModel.accountType == AccountType.Parent,
                  onTap: viewModel.onTapAccountType,
                ),
              ),
              Expanded(
                child: AccountTypeWidget(
                  accountType: AccountType.Student,
                  selected: viewModel.accountType == AccountType.Student,
                  onTap: viewModel.onTapAccountType,
                ),
              ),
              SizedBox(width: 6),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: MonkeyWidget(
                monkey: R.image.img_monkey_2(),
                text: AppLocalizations.of(context)!.please_select_the_person,
              ),
            ),
          ),
          SpecialButton(
            onPressed: () =>
                viewModel.onClickContinue(RegisterViewRoutes.nameView),
          ),
        ],
      ),
    );
  }
}
