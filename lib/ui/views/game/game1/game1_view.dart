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

import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/game_item_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'game1_view_model.dart';
import 'game_item_view.dart';

class Game1View extends ViewModelBuilderWidget<Game1ViewModel> {
  final Game1Option game;

  Game1View(this.game);

  @override
  Widget builder(
      BuildContext context, Game1ViewModel viewModel, Widget? child) {
    return Column(
      children: [
        SizedBox(height: 42),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
              text: TextSpan(children: [
            TextSpan(text: 'Which of this is', style: AppStyle.text30SB),
            TextSpan(
                text: ' ${game.question} ',
                style: AppStyle.text30SB.copyWith(color: AppColors.primary)),
            TextSpan(text: '?', style: AppStyle.text30SB),
          ])),
        ),
        SizedBox(height: 24),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 210,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              GameItemView(
                answerId: 1,
                blur: viewModel.game.image1blur,
                image: viewModel.game.image1,
                text: '${viewModel.game.image1text}',
              ),
              GameItemView(
                answerId: 2,
                blur: viewModel.game.image2blur,
                image: viewModel.game.image2,
                text: '${viewModel.game.image2text}',
              ),
              GameItemView(
                answerId: 3,
                blur: viewModel.game.image3blur,
                image: viewModel.game.image3,
                text: '${viewModel.game.image3text}',
              ),
              GameItemView(
                answerId: 4,
                blur: viewModel.game.image4blur,
                image: viewModel.game.image4,
                text: '${viewModel.game.image4text}',
              ),
            ],
          ),
        ),
        if (!viewModel.revealAnswer) SizedBox(height: 12),
        if (!viewModel.revealAnswer)
          TextButton.icon(
            onPressed: viewModel.onClickReveal,
            icon: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primary),
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: Image(
                image: R.svg.ic_book_2(width: 12.26, height: 14.58),
              ),
            ),
            label: Text(
              'Reveal Answer',
              style: AppStyle.text18SB.copyWith(color: AppColors.primary),
            ),
          ),
        if (viewModel.answer > 0)
          GameItemResult(isCorrect: viewModel.isCorrect()),
      ],
    );
  }

  @override
  Game1ViewModel viewModelBuilder(BuildContext context) =>
      Game1ViewModel(Provider.of(context), game);
}
