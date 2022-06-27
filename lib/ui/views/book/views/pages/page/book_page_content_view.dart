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
import 'package:easyenglish/ui/theme/color.dart';
import 'package:easyenglish/ui/theme/styles.dart';
import 'package:easyenglish/ui/views/book/views/pages/page/book_page_view_model.dart';
import 'package:easyenglish/ui/widgets/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BookPageContentView extends ViewModelWidget<BookPageViewModel> {
  const BookPageContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, BookPageViewModel viewModel) {
    return StreamWidget<List<Sentence>>(
      stream: viewModel.sentences,
      done: (data) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: data!.map((e) {
              return Wrap(
                spacing: 12,
                children: e.words
                    .map((e) => InkWell(
                          onTap: e.term > 0
                              ? () => viewModel.onTapTerm(e.term)
                              : null,
                          child: Text(
                            e.word,
                            style:
                                viewModel.highlightWordId == e.id || e.term > 0
                                    ? AppStyle.text24B
                                        .copyWith(color: AppColors.primary)
                                    : AppStyle.text24B,
                          ),
                        ))
                    .toList(),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
