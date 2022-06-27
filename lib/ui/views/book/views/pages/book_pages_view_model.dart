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
import 'package:easyenglish/core/services/books_service.dart';
import 'package:easyenglish/ui/views/book/book_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookPagesViewModel extends BaseViewModel {
  static const navKey = 104;
  final Book _book;
  final BooksService _booksService;
  final NavigationService _navigationService = GetIt.I.get();

  BookPagesViewModel(this._book, this._booksService);

  Book get book => _book;

  void onClickNext(int currentPageIndex) {
    _booksService.activityUpdate(_book.id, _book.pages[currentPageIndex].id);

    if (_book.pages.length - 1 >= currentPageIndex + 1)
      _navigationService.navigateTo(
        BookPagesViewRoutes.bookPageView,
        arguments: BookPageViewArguments(
          index: currentPageIndex + 1,
          page: _book.pages[currentPageIndex + 1],
        ),
        id: navKey,
      );
    else
      _navigationService.replaceWith(
        BookViewRoutes.bookCompleteView,
        id: BookViewModel.navKey,
      );
  }

  onClickPrevious(int currentPageIndex) {
    _booksService.activityUpdate(_book.id, _book.pages[currentPageIndex].id);

    if (currentPageIndex >= 0)
      _navigationService.navigateTo(
        BookPagesViewRoutes.bookPageView,
        arguments: BookPageViewArguments(
          index: currentPageIndex - 1,
          page: _book.pages[currentPageIndex - 1],
        ),
        id: navKey,
      );
  }

  Future<dynamic>? onTapTerm(int term) =>
      _navigationService.navigateTo(Routes.flashcardView,
          arguments: FlashcardViewArguments(termId: term));
}
