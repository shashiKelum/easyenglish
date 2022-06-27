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

import 'dart:ui';

import 'package:easyenglish/core/enums/game_type.dart';
import 'package:easyenglish/core/methods/typedefs.dart';
import 'package:easyenglish/core/models/game_selection_data_entity.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../r.g.dart';
import 'game_selection_item_view_model.dart';

class GameSelectionItem
    extends ViewModelBuilderWidget<GameSelectionItemViewModel> {
  final int index;
  final GameSelectionData data;
  final Callback<GameType> callback;

  const GameSelectionItem(
      {Key? key,
      required this.index,
      required this.data,
      required this.callback})
      : super(key: key);

  @override
  Widget builder(BuildContext context, GameSelectionItemViewModel viewModel,
      Widget? child) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8,
        left: index == 0 ? 16 : 0,
        right: index == GameType.values.length - 1 ? 16 : 0,
      ),
      child: Stack(
        children: [
          Button(
            enabled: false,
            disabledColor: data.gameType.color,
            disabledShadowColor: data.gameType.shadowColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: data.gameType.image),
                SizedBox(height: 28),
                Text(data.gameType.name, style: AppStyle.text25B),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: R.svg.ic_game_badge(width: 28.68, height: 39.5),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(data.progress <= 0)
                        Text(
                          'UNLOCK ACHIEVEMENT',
                          style: AppStyle.text10SB,
                        ),
                        Text(
                          'Spelling Bee!',
                          style: AppStyle.text18SB
                              .copyWith(color: AppColors.textHighlight),
                        ),
                        if(data.progress > 0)
                        Text(
                          'Level ${data.level}',
                          style: AppStyle.text10SB
                              .copyWith(color: AppColors.textHighlight),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 34),
                SpecialButton(
                  width: 161.88,
                  height: 40,
                  flipY: true,
                  fontSize: 19,
                  onPressed: () => callback(data.gameType),
                  text: 'Play',
                ),
              ],
            ),
            width: 230,
            height: 364,
          ),
          if (data.progress > 0)
            Positioned(
              top: 0,
              left: 10,
              width: 43,
              height: 47,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 3,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaY: 2),
                      child: Image(
                        image: R.svg.bg_game_percentage(width: 43, height: 43),
                        color: data.gameType.percentageShadowColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Image(
                      image: R.svg.bg_game_percentage(width: 43, height: 43),
                      color: data.gameType.percentageColor,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    width: 43,
                    height: 43,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '${viewModel.getProgress(data.progress)}%',
                        style: AppStyle.text16B.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  @override
  GameSelectionItemViewModel viewModelBuilder(BuildContext context) =>
      GameSelectionItemViewModel(index, data);
}
