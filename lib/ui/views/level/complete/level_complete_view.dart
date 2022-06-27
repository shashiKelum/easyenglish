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

import 'package:easyenglish/ui/views/complete/complete_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'level_complete_view_model.dart';

class LevelCompleteView extends ViewModelBuilderWidget<LevelCompleteViewModel> {
  final int level;
  final int unit;

  const LevelCompleteView({
    Key? key,
    required this.level,
    required this.unit,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, LevelCompleteViewModel viewModel, Widget? child) {
    return Scaffold(
      body: CompleteView(
        title: 'Unit $unit',
        buttonText: 'Go to Dashboard',
        level: level,
        onTabButton: viewModel.onTapContinue,
      ),
    );
  }

  @override
  LevelCompleteViewModel viewModelBuilder(BuildContext context) =>
      LevelCompleteViewModel(level, unit);
}
