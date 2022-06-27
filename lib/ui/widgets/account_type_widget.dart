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

import 'package:easyenglish/core/enums/account_type.dart';
import 'package:easyenglish/core/methods/typedefs.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:flutter/material.dart';

class AccountTypeWidget extends StatelessWidget {
  final AccountType accountType;
  final bool selected;
  final Callback<AccountType> onTap;

  const AccountTypeWidget(
      {Key? key,
      required this.accountType,
      this.selected = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: () => onTap(accountType),
            child: AspectRatio(
              aspectRatio: 1,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: selected ? AppColors.primary : Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: AppColors.border1, width: 2.0),
                ),
                child: Image(
                  image: accountType.icon!,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            accountType.text,
            style: AppStyle.text18SB.copyWith(
              color: selected ? AppColors.primary : AppColors.textPrimary,
            ),
          )
        ],
      ),
    );
  }
}
