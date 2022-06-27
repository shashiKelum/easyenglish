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
import 'package:flutter/material.dart';

enum AccountType { Parent, Student, Guest }

extension AccountTypeExtension on AccountType? {
  String get text {
    switch (this) {
      case AccountType.Parent:
        return LocaleKeys.register_im_a_parent.tr();
      case AccountType.Student:
        return LocaleKeys.register_im_a_student.tr();
      default:
        return LocaleKeys.register_im_a_guest.tr();
    }
  }

  int get value {
    switch (this) {
      case AccountType.Parent:
        return 1;
      case AccountType.Student:
        return 0;
      default:
        return -1;
    }
  }

  ImageProvider? get icon {
    switch (this) {
      case AccountType.Parent:
        return R.svg.img_parent(width: 136, height: 134);
      case AccountType.Student:
        return R.svg.img_boy(width: 97.39, height: 135.32);
      case AccountType.Guest:
        return null;
    }
  }
}
