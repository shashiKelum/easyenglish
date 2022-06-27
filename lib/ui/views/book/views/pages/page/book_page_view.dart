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

import 'dart:io';
import 'dart:math';

import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/views/book/views/pages/page/book_page_audio_controller_view.dart';
import 'package:easyenglish/ui/views/book/views/pages/page/book_page_content_view.dart';
import 'package:easyenglish/ui/views/book/views/pages/page/book_page_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class BookPageView extends ViewModelBuilderWidget<BookPageViewModel> {
  final int index;
  final BookPage page;

  BookPageView(this.index, this.page);

  @override
  Widget builder(
      BuildContext context, BookPageViewModel viewModel, Widget? child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: FadeInImage(
              image: FileImage(File(viewModel.page.imagePath)),
              placeholder: BlurHashImage(viewModel.page.imageBlurhash),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: BookPageContentView()),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Button(
                    width: 46,
                    height: 46,
                    color: AppColors.primary,
                    shadowColor: AppColors.primaryDark,
                    child: Image(
                      image: R.svg.ic_tortoise(width: 33, height: 16),
                    ),
                    onTap: viewModel.onTapSpeed,
                  ),
                  if (index > 0) SizedBox(height: 16),
                  if (index > 0)
                    Button(
                      width: 46,
                      height: 46,
                      enabled: viewModel.nextButtonEnabled,
                      color: AppColors.secondary,
                      shadowColor: AppColors.secondaryDark,
                      child: Center(
                        child: Image(
                          image: R.image.ic_arrow_back(),
                          color: viewModel.nextButtonEnabled
                              ? Colors.white
                              : AppColors.textDisabled,
                        ),
                      ),
                      onTap: viewModel.onClickPrevious,
                    ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: BookPageAudioControllerView()),
            SizedBox(width: 16),
            Button(
              width: 46,
              height: 46,
              enabled: viewModel.nextButtonEnabled,
              color: AppColors.secondary,
              shadowColor: AppColors.secondaryDark,
              child: Center(
                child: Transform.rotate(
                  angle: pi / 1.0,
                  child: Image(
                    image: R.image.ic_arrow_back(),
                    color: viewModel.nextButtonEnabled
                        ? Colors.white
                        : AppColors.textDisabled,
                  ),
                ),
              ),
              onTap: viewModel.onClickNext,
            ),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  BookPageViewModel viewModelBuilder(BuildContext context) => BookPageViewModel(
      index, page, Provider.of(context), Provider.of(context), Provider.of(context));

  @override
  void onViewModelReady(BookPageViewModel viewModel) => viewModel.init();
}
