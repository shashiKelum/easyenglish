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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/game/game1/game1_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:stacked/stacked.dart';

class GameItemView extends ViewModelWidget<Game1ViewModel> {
  final int answerId;
  final String image;
  final String blur;
  final String text;

  GameItemView(
      {required this.answerId,
      required this.image,
      required this.blur,
      required this.text});

  @override
  Widget build(BuildContext context, Game1ViewModel viewModel) {
    bool pass = viewModel.isPass(answerId);
    bool fail = viewModel.isFail(answerId);
    bool correct = viewModel.isCorrect(answerId);
    return Button(
      width: 156,
      height: 210,
      color: pass || correct
          ? AppColors.gamePassColor
          : fail
              ? AppColors.gameFailColor
              : AppColors.buttonDefault,
      shadowColor: pass || correct
          ? AppColors.gamePassShadowColor
          : fail
              ? AppColors.gameFailShadowColor
              : AppColors.buttonDefaultShadow,
      onTap: () => viewModel.onClickAnswer(answerId),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Column(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: image,
                  placeholder: (context, url) => Image(
                    image: BlurHashImage(blur),
                    fit: BoxFit.fitWidth,
                  ),
                  errorWidget: (context, url, error) => Image(
                    image: BlurHashImage(blur),
                    fit: BoxFit.fitWidth,
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            if (viewModel.revealAnswer)
              Text(
                '$text',
                style: AppStyle.text22SB.copyWith(color: AppColors.textPrimary),
              ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
