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
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/book/book_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/special_button.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:stacked/stacked.dart';

class BookCoverView extends ViewModelWidget<BookViewModel> {
  @override
  Widget build(BuildContext context, BookViewModel viewModel) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: viewModel.initialBook.image,
          placeholder: (context, url) => Image(
            image: BlurHashImage(viewModel.initialBook.imageBlurHash),
            fit: BoxFit.cover,
          ),
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${viewModel.initialBook.title}',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(color: Colors.white),
            ),
            Text(
              '${viewModel.initialBook.subtitle}',
              style: AppStyle.text26B,
            ),
            SizedBox(height: 16),
            StreamWidget<double>(
              stream: viewModel.bookDownloadProgress,
              done: (data) => SpecialButton(
                  text: 'Start Reading!',
                  onPressed: (((data ?? 0) < 1) ? null : viewModel.onTapStart)),
            ),
            SizedBox(height: 24),
            StreamWidget<double>(
              stream: viewModel.bookDownloadProgress,
              done: (data) => LinearProgressIndicator(
                value: data,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
