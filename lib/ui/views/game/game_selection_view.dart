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

import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/game_selection_data_entity.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/game/game_selection_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/app_bar_back_button.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:easyenglish/ui/widgets/error_view.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'selection_item/game_selection_item.dart';

class GameSelectionView extends ViewModelBuilderWidget<GameSelectionViewModel> {
  final Book book;

  const GameSelectionView(this.book);

  @override
  Widget builder(
      BuildContext context, GameSelectionViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(
            icon: R.svg.ic_home_nav(width: 24, height: 24),
            callback: viewModel.onClickBack),
        leadingWidth: 64,
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
            child: Button(
              child: Center(
                child: Image(image: R.svg.ic_lang_si(width: 24, height: 24)),
              ),
              onTap: viewModel.onClickBack,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Let\'s have some fun!', style: AppStyle.text30SB),
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 370,
              child: StreamWidget<List<GameSelectionData>>(
                stream: viewModel.data,
                done: (data) {
                  if (data == null)
                    return ErrorView(
                      message: ErrorMessages.SOMETHING_WENT_WRONG,
                    );

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) => GameSelectionItem(
                      index: index,
                      data: data[index],
                      callback: viewModel.onClickGame,
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 16),
                  );
                },
              ),
            ),
            Expanded(child: SizedBox(height: 24)),
            SpecialButton(
              onPressed: viewModel.onClickContinue,
              text: 'Continue to next Book',
            ),
          ],
        ),
      ),
    );
  }

  @override
  GameSelectionViewModel viewModelBuilder(BuildContext context) =>
      GameSelectionViewModel(book, Provider.of(context));
}
