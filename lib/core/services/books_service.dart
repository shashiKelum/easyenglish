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

import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/dictionary_entity.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/core/services/api/api.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class BooksService {
  static const TAG = 'BooksService';
  final Api _api;
  final AppStateService _appStateService;
  final BehaviorSubject<double> _downloadProgress = BehaviorSubject.seeded(0);

  BooksService(this._api, this._appStateService);

  BehaviorSubject<double> get downloadProgress => _downloadProgress;

  Future<List<Book>?> getAllBooks() {
    return _api.allBooks().then((value) {
      if (value.status) {
        return value.data?.books;
      } else {
        return Future.error(
            value.message ?? ErrorMessages.SOMETHING_WENT_WRONG);
      }
    }, onError: (error) => Future.error('$error'));
  }

  Future<Book> getCurrentBook() {
    return _api.customerCurrentBook().then((value) async {
      if (value.status) {
        if (value.data != null) {
          return value.data!.books;
        } else
          return Future.error('Book not available');
      } else {
        return Future.error(
            value.message ?? ErrorMessages.SOMETHING_WENT_WRONG);
      }
    }, onError: (error) => Future.error('$error'));
  }

  Future<Book> getBook(int id) {
    return _api.book(id: id).then((value) async {
      if (value.status) {
        if (value.data != null) {
          final _book = await _downloadBook(value.data!.book);
          return _book;
        } else
          return Future.error('Book not available');
      } else {
        return Future.error(
            value.message ?? ErrorMessages.SOMETHING_WENT_WRONG);
      }
    }, onError: (error) => Future.error('$error'));
  }

  Future<Book> _downloadBook(Book book) async {
    List<dynamic> filePaths = [];
    for (BookPage page in book.pages) {
      final root = await getApplicationSupportDirectory();
      final imageFilePath =
          page.imagePath = '${root.path}/book/${book.id}/${page.id}/image.jpg';
      final audioFilePath =
          page.audioPath = '${root.path}/book/${book.id}/${page.id}/audio.aac';

      if (!File(page.imagePath).existsSync())
        filePaths.add({'url': page.image, 'path': imageFilePath});
      if (!File(page.audioPath).existsSync())
        filePaths.add({'url': page.audio, 'path': audioFilePath});
    }

    for (Game2Option game in book.games.g2.games) {
      final root = await getApplicationSupportDirectory();
      final audioFilePath =
          game.audioPath = '${root.path}/book/${book.id}/g2/${game.id}/audio.aac';

      if (!File(audioFilePath).existsSync())
        filePaths.add({'url': game.audio, 'path': audioFilePath});
    }

    final totalAssets = filePaths.length;

    for (int i = 0; i < filePaths.length; i++) {
      final asset = filePaths[i];
      await _api.download(
        urlPath: asset['url'],
        filePath: asset['path'],
        progressCallback: (count, total) {},
      );
      _downloadProgress.add((i + 1) / totalAssets);
    }

    _downloadProgress.add(1);
    return book;
  }

  void activityUpdate(int bookId, int pageId) {
    Log.d(TAG, 'bookId: $bookId, pageId: $pageId',
        references: ['activityUpdate']);
    _api.bookActivity(bookId: bookId, pageId: pageId);
  }

  Future<Term> getTerm(int termId) {
    return _api.term(termId: termId).then((value) async {
      if (value.status) {
        return await downloadTerm(value.data.term);
      } else {
        return Future.error('${value.message}');
      }
    }, onError: (error) => Future.error('$error'));
  }

  Future<Term> downloadTerm(Term term) async {
    if (term.audioClip == null) return term;

    List<dynamic> filePaths = [];
    final root = await getApplicationSupportDirectory();
    final audioFilePath = term.audioPath =
        '${root.path}/terms/${term.id}/audio.${getExt(term.audioClip!)}';

    if (!File(term.audioPath!).existsSync())
      filePaths.add({'url': term.audioClip, 'path': audioFilePath});

    for (int i = 0; i < filePaths.length; i++) {
      final asset = filePaths[i];
      await _api.download(urlPath: asset['url'], filePath: asset['path']);
    }

    return term;
  }

  String getExt(String url) {
    return url.substring(url.length - 3, url.length);
  }

  Future<List<Dictionary>> getDictionary(int bookId) {
    return _api.dictionary(bookId: bookId).then((value) async {
      if (value.status) {
        if(value.data != null) {
          return value.data!.bookTerms;
        } else {
          return Future.error(ErrorMessages.SOMETHING_WENT_WRONG);
        }
      } else {
        return Future.error('${value.message}');
      }
    }, onError: (error) => Future.error('$error'));
  }
}
