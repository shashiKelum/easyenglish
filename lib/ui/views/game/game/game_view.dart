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

import 'package:easyenglish/core/enums/game_type.dart';
import 'package:easyenglish/core/models/game_entity.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/game/game/game_state/game_state_view.dart';
import 'package:easyenglish/ui/views/game/game/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class GameView extends ViewModelBuilderWidget<GameViewModel> {
  final int bookId;
  final int bookLevel;
  final GameType gameType;
  final dynamic game;

  GameView(this.bookId, this.bookLevel, this.gameType, this.game);

  @override
  Widget builder(BuildContext context, GameViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: viewModel.onClickClose,
          icon: Image(
            image: R.svg.ic_close(width: 20, height: 20),
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: true,
        title: GameStateView(
          gameStateList:
              viewModel.items.map((e) => (e as GameBaseOption).gameItemState).toList(),
        ),
        actions: [
          TextButton(
            child: Row(
              children: [
                Image(
                  image: R.image.ic_crown(),
                  fit: BoxFit.cover,
                  width: 34,
                  height: 34,
                ),
                Text(
                  '${viewModel.successCount}',
                  style: AppStyle.text22SB,
                ),
              ],
            ),
            onPressed: null,
          ),
        ],
      ),
      body: PageView.builder(
        controller: viewModel.controller,
        physics: NeverScrollableScrollPhysics(),
        itemCount: viewModel.items.length,
        itemBuilder: (context, index) => viewModel.getGamePage(context, index),
      ),
    );
  }

  @override
  GameViewModel viewModelBuilder(BuildContext context) =>
      GameViewModel(Provider.of(context), bookId, bookLevel, gameType, game);

  @override
  void onViewModelReady(GameViewModel viewModel) => viewModel.init();
}
