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
import 'package:easyenglish/ui/views/game/complete/game_complete_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GameCompleteView extends ViewModelBuilderWidget<GameCompleteViewModel> {
  final String title;
  final String buttonText;
  final int level;

  const GameCompleteView({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.level,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, GameCompleteViewModel viewModel, Widget? child) {
    return Scaffold(
      body: CompleteView(
        title: title,
        buttonText: buttonText,
        level: level,
        onTabButton: viewModel.onTapContinue,
      ),
    );
  }

  @override
  GameCompleteViewModel viewModelBuilder(BuildContext context) =>
      GameCompleteViewModel();
}
