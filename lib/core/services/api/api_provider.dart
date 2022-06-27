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

import '../../../core/services/api/api.dart';
import '../../../core/services/api/api_client.dart';

class ApiProvider implements Api {
  static const String TAG = 'ApiProvider';

  late ApiClient _apiClient;

  static final ApiProvider _singleton = ApiProvider.internal();

  factory ApiProvider(ApiClient apiClient) {
    _singleton._apiClient = apiClient;
    return _singleton;
  }

  ApiProvider.internal();

  @override
  Future<LoginEntity> login(
      {String? firebaseRegId, String? mobileNo, String? email}) {
    return _apiClient.post<LoginEntity>('api/auth/user_auth', data: {
      'os_type': Platform.isAndroid ? 'A' : 'I',
      'firebase_reg_id': firebaseRegId,
      'phone': mobileNo,
      'email': email,
    });
  }

  @override
  Future<LoginEntity> verifyLogin(
      {required String mobileNo, required String otp}) {
    return _apiClient.post<LoginEntity>('api/auth/verifylogin', data: {
      'os_type': Platform.isAndroid ? 'A' : 'I',
      'phone': mobileNo,
      'sms_token': otp,
    });
  }

  @override
  Future<LoginEntity> register(
      {required String name,
      required int isParent,
      String? firebaseRegId,
      String? mobileNo,
      String? email}) {
    return _apiClient.post<LoginEntity>('api/auth/register', data: {
      'name': name,
      'is_parent': isParent,
      'os_type': Platform.isAndroid ? 'A' : 'I',
      'firebase_reg_id': firebaseRegId,
      'mobile_no': mobileNo,
      'email': email,
    });
  }

  @override
  Future<SongsEntity> allSongs() {
    return _apiClient.get<SongsEntity>('api/songs/all');
  }

  @override
  Future<SongEntity> song({required int id}) {
    return _apiClient.get<SongEntity>('api/song/song/$id');
  }

  @override
  Future<BooksEntity> allBooks() {
    return _apiClient.get<BooksEntity>('api/books/customer');
  }

  @override
  Future<BooksEntity> customerBooks() {
    return _apiClient.get<BooksEntity>('api/books/customer');
  }

  @override
  Future<BookEntity> book({required int id}) {
    return _apiClient.get<BookEntity>('api/books/customer/book/$id');
  }

  @override
  Future<BookGamesEntity> games({required int id}) {
    return _apiClient.get<BookGamesEntity>('api/books/customer/book/$id/game');
  }

  @override
  Future<void> download(
      {required String urlPath,
      required String filePath,
      CancelToken? cancelToken,
      ProgressCallback? progressCallback}) async {
    await _apiClient.download(
      urlPath,
      filePath,
      cancelToken: cancelToken,
      onReceiveProgress: progressCallback,
    ).catchError((error) {
      print('error => $error');
    });
  }

  @override
  Future<BaseEntity> bookActivity({required int bookId, required int pageId}) {
    return _apiClient.post('api/book/activity', data: {
      'book_id': bookId,
      'ref_id': pageId,
      'action': 'PG',
    });
  }

  @override
  Future<BaseEntity> gameActivity(
      {required int bookId, required int gameId, required GameType type}) {
    return _apiClient.post('api/book/activity', data: {
      'book_id': bookId,
      'ref_id': gameId,
      'action': type.action,
    });
  }

  @override
  Future<CurrentBookEntity> customerCurrentBook() {
    return _apiClient.get('api/books/customer/currentbook');
  }

  @override
  Future<TermEntity> term({required int termId}) {
    return _apiClient.get('api/term/$termId');
  }

  @override
  Future<DictionaryEntity> dictionary({required int bookId}) {
    return _apiClient.get('api/books/customer/book/$bookId/terms');
  }
}
