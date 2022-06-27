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

class BookViewModel extends BaseViewModel {
  static const navKey = 103;
  final Book _initialBook;
  final BooksService _booksService;
  final NavigationService _navigationService = GetIt.I.get();
  final BehaviorSubject<Book> _book = BehaviorSubject();
  final BehaviorSubject<bool> _pauseAudioController = BehaviorSubject();

  BookViewModel(this._booksService, this._initialBook) {
    _getBook();
  }

  BehaviorSubject<double> get bookDownloadProgress =>
      _booksService.downloadProgress;

  Book get initialBook => _initialBook;

  BehaviorSubject<Book> get book => _book;

  BehaviorSubject<bool> get pauseAudio => _pauseAudioController;

  void onClickBack() => _navigationService.back();

  void onTapStart() {
    _navigationService.replaceWith(
      BookViewRoutes.bookPreludeView,
      id: navKey,
      arguments: BookPreludeViewArguments(preludes: book.value.preludeTerms),
    );
  }

  void _getBook() async {
    _booksService.getBook(_initialBook.id).then((value) => _book.add(value),
        onError: (error) => _book.addError(error));
  }

  void onTapPlay() {
    _navigationService.replaceWith(Routes.gameSelectionView,
        arguments: GameSelectionViewArguments(book: book.value));
  }

  void onTapDictionary() {
    _pauseAudioController.add(true);
    _navigationService
        .navigateTo(Routes.dictionaryView,
            arguments: DictionaryViewArguments(bookId: _initialBook.id))
        ?.then((value) => _pauseAudioController.add(false));
  }

  void onTapPreludeNext() {
    _navigationService.replaceWith(
      BookViewRoutes.bookPagesView,
      id: navKey,
      arguments: BookPagesViewArguments(book: book.value),
    );
  }
}
