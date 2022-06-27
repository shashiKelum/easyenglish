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

import 'package:dio/dio.dart';
import 'package:easyenglish/core/enums/game_type.dart';
import 'package:easyenglish/core/models/base_entity.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/book_games_entity.dart';
import 'package:easyenglish/core/models/books_entity.dart';
import 'package:easyenglish/core/models/current_book_entity.dart';
import 'package:easyenglish/core/models/dictionary_entity.dart';
import 'package:easyenglish/core/models/login_entity.dart';
import 'package:easyenglish/core/models/song_entity.dart';
import 'package:easyenglish/core/models/songs_entity.dart';
import 'package:easyenglish/core/models/term_entity.dart';

abstract class Api {
  Future<LoginEntity> login(
      {String? firebaseRegId, String? mobileNo, String? email});

  Future<LoginEntity> verifyLogin({required String mobileNo, required String otp});

  Future<LoginEntity> register(
      {required String name,
      required int isParent,
      String? firebaseRegId,
      String? mobileNo,
      String? email});

  Future<SongsEntity> allSongs();

  Future<SongEntity> song({required int id});

  Future<BooksEntity> allBooks();

  Future<BooksEntity> customerBooks();

  Future<BookEntity> book({required int id});

  Future<BookGamesEntity> games({required int id});

  Future<BaseEntity> bookActivity({required int bookId, required int pageId});

  Future<BaseEntity> gameActivity(
      {required int bookId, required int gameId, required GameType type});

  Future<void> download(
      {required String urlPath,
      required String filePath,
      CancelToken? cancelToken,
      ProgressCallback? progressCallback});

  Future<CurrentBookEntity> customerCurrentBook();

  Future<TermEntity> term({required int termId});

  Future<DictionaryEntity> dictionary({required int bookId});
}
