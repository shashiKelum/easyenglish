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
import 'package:easyenglish/ui/views/book/views/pages/book_pages_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookPagesView extends ViewModelBuilderWidget<BookPagesViewModel> {
  final Book book;

  BookPagesView(this.book);

  @override
  Widget builder(
      BuildContext context, BookPagesViewModel viewModel, Widget? child) {
    return ExtendedNavigator(
      router: BookPagesViewRouter(),
      navigatorKey:
          StackedService.nestedNavigationKey(BookPagesViewModel.navKey),
      initialRouteArgs: BookPageViewArguments(index: 0, page: book.pages.first),
    );
  }

  @override
  BookPagesViewModel viewModelBuilder(BuildContext context) =>
      BookPagesViewModel(book, Provider.of(context));
}
