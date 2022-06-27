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
import 'package:flutter/material.dart';

class MobileNumberField extends StatelessWidget {
  final String? initialValue;
  final bool readOnly;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const MobileNumberField({
    Key? key,
    required this.controller,
    this.initialValue,
    this.readOnly = false,
    this.validator,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              initialValue: '+94',
              textAlign: TextAlign.center,
              readOnly: true,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.phone,
              initialValue:
                  initialValue != null && initialValue!.contains('+94')
                      ? initialValue!.replaceAll('+94', '')
                      : initialValue,
              readOnly: readOnly,
              validator: validator,
              decoration: InputDecoration(
                hintText: LocaleKeys.register_enter_phone_number.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
