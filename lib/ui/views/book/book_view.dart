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

import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/r.g.dart';
import 'package:easyenglish/ui/views/book/book_view_model.dart';
import 'package:easyenglish/ui/widgets/buttons/app_bar_back_button.dart';
import 'package:easyenglish/ui/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookView extends ViewModelBuilderWidget<BookViewModel> {
  final Book book;

  BookView(this.book);

  @override
  Widget builder(BuildContext context, BookViewModel viewModel, Widget? child) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: AppBarBackButton(callback: viewModel.onClickBack),
        leadingWidth: 64,
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Button(
                onTap: viewModel.onTapDictionary,
                child: Image(image: R.svg.ic_question(width: 13.58, height: 18.81)),
              ),
            ),
          )
        ],
      ),
      body: ExtendedNavigator(
        router: BookViewRouter(),
        navigatorKey:
            StackedService.nestedNavigationKey(BookViewModel.navKey),
      ),
    );
  }

  @override
  BookViewModel viewModelBuilder(BuildContext context) =>
      BookViewModel(Provider.of(context), book);
}
