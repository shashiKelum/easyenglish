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
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardBooksViewModel extends BaseViewModel {
  final BooksService _booksService;
  final BehaviorSubject<List<Book>?> _books = BehaviorSubject();
  final NavigationService _navigationService = GetIt.I.get();

  DashboardBooksViewModel(this._booksService) {
    _getBooks();
  }

  BehaviorSubject<List<Book>?> get books => _books;

  @override
  void dispose() async {
    await books.close();
    super.dispose();
  }

  void _getBooks() {
    _booksService.getAllBooks().then((value) => _books.add(value),
        onError: (error) => _books.addError(error));
  }

  void onTapBook(Book book) {
    if (book.subscribe == 1) {
      _navigationService.navigateTo(Routes.bookView,
          arguments: BookViewArguments(book: book));
    }
  }
}
