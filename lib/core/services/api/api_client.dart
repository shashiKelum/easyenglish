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

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/models/book_games_entity.dart';
import 'package:easyenglish/core/models/books_entity.dart';
import 'package:easyenglish/core/models/current_book_entity.dart';
import 'package:easyenglish/core/models/dictionary_entity.dart';
import 'package:easyenglish/core/models/login_entity.dart';
import 'package:easyenglish/core/models/profile_entity.dart';
import 'package:easyenglish/core/models/refresh_token_entity.dart';
import 'package:easyenglish/core/models/song_entity.dart';
import 'package:easyenglish/core/models/songs_entity.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/generated/json/base/json_convert_content.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:fresh_dio/fresh_dio.dart';

import '../../../core/config/application.dart';
import '../../../core/enums/auth_state.dart';
import '../../../core/models/base_entity.dart';
import '../app_state_service.dart';
import 'api_key_gen.dart';

class ApiClient {
  static const String TAG = 'ApiClient';

  final options = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),
    // Default.
    policy: CachePolicy.forceCache,
    // Optional. Returns a cached response on error but for statuses 401 & 403.
    hitCacheOnErrorExcept: [401, 403, 404],
    // Optional. Overrides any HTTP directive to delete entry past this duration.
    maxStale: const Duration(days: 3),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended.
    allowPostMethod: false,
  );

  Dio _dio = new Dio();
  Dio _tokenDio = new Dio();
  Dio _assetsDio = new Dio();
  late AppStateService _appState;
  String? _csrfToken;

  ApiClient(AppStateService appState) {
    this._appState = appState;
    _dio.options = BaseOptions(
      baseUrl: Application.baseUrl,
      responseType: ResponseType.json,
      connectTimeout: 1000 * 60,
      receiveTimeout: 1000 * 30,
      sendTimeout: 1000 * 45,
    );
    _tokenDio.options = BaseOptions(
      baseUrl: Application.baseUrl,
      responseType: ResponseType.json,
      connectTimeout: 1000 * 60,
      receiveTimeout: 1000 * 30,
      sendTimeout: 1000 * 45,
    );
    _assetsDio.options = BaseOptions(
      responseType: ResponseType.bytes,
      connectTimeout: 1000 * 60,
      receiveTimeout: 1000 * 60,
      sendTimeout: 1000 * 60,
      followRedirects: false,
    );
    _setupAuthInterceptor();
    _setupLoggingInterceptor();
    _setupCacheInterceptor();
  }

  void _setupAuthInterceptor() {
    final interceptors = InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          options.headers['x-authorization'] = Application.authKey;

          var keyGen = ApiKeyGen.generate();
          if (Application.authBody && options.method == "GET") {
            options.queryParameters['time-stamp'] = keyGen.timeStamp;
            options.queryParameters['api-token'] = keyGen.key;
          } else {
            if (Application.authHeader) {
              options.headers['time-stamp'] = keyGen.timeStamp;
              options.headers['api-token'] = keyGen.key;
            }

            if (Application.authBody) {
              Map<String, dynamic> data =
                  options.data ?? Map<String, dynamic>();

              data.putIfAbsent('time-stamp', () => keyGen.timeStamp);
              data.putIfAbsent('api-token', () => keyGen.key);

              options.data = data;
            }
          }

          // if (_csrfToken != null && _csrfToken!.isNotEmpty) {
          //   options.headers["authorization"] = getAuthToken(_csrfToken);
          // } else {
          //   _csrfToken = getToken(options.headers['authorization']);
          // }
          return handler.next(options);
        } on Exception catch (e) {
          Log.e(TAG, '$e', references: ['AuthInterceptor'], exception: e);
          return handler.reject(DioError(requestOptions: options, error: e));
        }
      },
      onError: (error, handler) async {
        Log.e(TAG, 'onError $error', exception: error.error);
        // Assume 401 stands for token expired
        if (error.response?.statusCode == 401 &&
            error.response!.requestOptions.headers["authorization"] != null) {
          RequestOptions options = error.requestOptions;
          // If the token has been updated, repeat directly.
          if (_csrfToken != null &&
              _csrfToken!.isNotEmpty &&
              _csrfToken != getToken(options.headers["authorization"])) {
            options.headers["authorization"] = getAuthToken(_csrfToken);
            //repeat
            // return _dio.request(options.path,
            //     options: getOptions(options, _csrfToken));
            return handler.resolve(await _dio.request(options.path,
                options: getOptions(options, _csrfToken)));
          } else {
            _csrfToken = getToken(options.headers["authorization"]);
          }

          return _refreshToken(options);
        }

        return handler.reject(error);
      },
      onResponse: (e, handler) {
        Log.i(TAG, e.statusMessage!, references: ['onResponse']);
        return handler.next(e);
      },
    );
    _dio = _dio..interceptors.add(interceptors);
    _dio.interceptors.add(interceptors);
  }

  void _setupLoggingInterceptor() {
    var loginInterceptor = LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (val) => Log.d(TAG, val as String),
    );
    _dio.interceptors.add(loginInterceptor);
    _tokenDio.interceptors.add(loginInterceptor);
    _assetsDio.interceptors.add(loginInterceptor);
  }

  void _setupCacheInterceptor() {
    _dio.interceptors.add(DioCacheInterceptor(options: options));
  }

  Options getOptions(RequestOptions requestOptions, String? token) {
    return Options(
      method: requestOptions.method,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      extra: requestOptions.extra,
      headers: requestOptions.headers..addAll(_setToken(token)),
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      validateStatus: requestOptions.validateStatus,
      receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
      followRedirects: requestOptions.followRedirects,
      maxRedirects: requestOptions.maxRedirects,
      requestEncoder: requestOptions.requestEncoder,
      responseDecoder: requestOptions.responseDecoder,
      listFormat: requestOptions.listFormat,
    );
  }

  T _handleError<T>(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = ErrorMessages.REQUEST_TO_SERVER_WAS_CANCELLED;
          break;
        case DioErrorType.connectTimeout:
          errorDescription = ErrorMessages.CONNECTION_TIMEOUT_SERVER;
          break;
        case DioErrorType.other:
          errorDescription = ErrorMessages.CONNECTIVITY_ISSUE_TRY_AGAIN;
          break;
        case DioErrorType.sendTimeout:
          errorDescription = ErrorMessages.SEND_TIMEOUT_SERVER;
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = ErrorMessages.RECEIVE_TIMEOUT_SERVER;
          break;
        case DioErrorType.response:
          switch (error.response?.statusCode) {
            case 403:
              try {
                var r = json.encode(error.response?.data);
                return JsonConvert.fromJsonAsT(json.decode(r));
              } catch (e) {
                errorDescription = ErrorMessages.SOMETHING_WENT_WRONG;
              }
              break;
            default:
              errorDescription =
                  '${ErrorMessages.SOMETHING_WENT_WRONG}\nstatus code: ${error.response?.statusCode}';
              break;
          }
          break;
      }
    } else {
      errorDescription = ErrorMessages.UNEXPECTED_ERROR_OCCURRED;
    }
    return getEntity<T>({
      "status": false,
      "error": [errorDescription],
    });
  }

  Map<String, dynamic> _setToken(token, [Map<String, dynamic>? headers]) {
    if (headers != null) {
      headers.putIfAbsent('authorization', () => getAuthToken(token));
      return headers;
    } else {
      return {'authorization': getAuthToken(token)};
    }
  }

  String getToken(token) {
    return (token ?? '').toString().replaceFirst('Bearer ', '');
  }

  String getAuthToken(token) {
    return 'Bearer $token';
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(path,
          queryParameters: queryParameters,
          options: await _defaultOptions(options),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      return _validateResponse(response);
    } on DioError catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<T> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: await _defaultOptions(options),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      return _validateResponse(response);
    } on DioError catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<T> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(path,
          data: data,
          queryParameters: queryParameters,
          options: await _defaultOptions(options),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      return _validateResponse(response);
    } on DioError catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<T> delete<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio.delete(path,
          data: data,
          queryParameters: queryParameters,
          options: await _defaultOptions(options),
          cancelToken: cancelToken);

      return _validateResponse(response);
    } on DioError catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<void> download(
    String urlPath,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _assetsDio.download(urlPath, savePath,
          queryParameters: queryParameters,
          options: await _defaultOptions(options),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      return;
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  Future<Options> _defaultOptions(Options? options) async {
    var state = await _appState.getAuthState();
    var user = _appState.userValue;
    if (state != null &&
        (state == AuthState.SignedIn ||
            state == AuthState.Anonymous ||
            state == AuthState.Expired) &&
        user != null &&
        user.token != null &&
        user.token!.isNotEmpty) {
      if (options != null) {
        options.headers =
            _authoriseRequest(_setToken(user.token, options.headers));
        return options;
      } else {
        return Options(headers: _authoriseRequest(_setToken(user.token)));
      }
    } else {
      if (options != null) {
        options.headers = _authoriseRequest(options.headers);
        return options;
      } else {
        return Options(headers: _authoriseRequest());
      }
    }
  }

  //Temporary solution
  Map<String, dynamic> _authoriseRequest([Map<String, dynamic>? headers]) {
    var keyGen = ApiKeyGen.generate();

    if (headers != null) {
      headers.putIfAbsent('x-authorization', () => Application.authKey);
      headers.putIfAbsent('time-stamp', () => keyGen.timeStamp);
      headers.putIfAbsent('api-token', () => keyGen.key);
      return headers;
    } else {
      return {
        'x-authorization': Application.authKey,
        'time-stamp': keyGen.timeStamp,
        'api-token': keyGen.key,
      };
    }
  }

  Future<T> _validateResponse<T>(Response<dynamic> response) async {
    try {
      var common = getEntity<BaseEntity>(response.data);
      if (common.status) {
        return getEntity<T>(response.data);
      } else {
        // TODO handle token refresh
        // if (common.code == 1004 &&
        //     common.extra != null &&
        //     common.extra.action != null &&
        //     common.extra.action == 'LOGIN') {
        //   var res = await _refreshToken(response.request);
        //   print(res);
        //   return getEntity<T>(res.data);
        // } else {
        return getEntity<T>(response.data);
        // }
      }
    } on Exception catch (e) {
      Log.e(TAG, 'validating response', exception: e);
      return _handleError<T>(e as DioError);
    }
  }

  _refreshToken(RequestOptions options) {
    // update token and repeat
    // Lock to block the incoming request until the token updated
    _dio.lock();
    _dio.interceptors.responseLock.lock();
    _dio.interceptors.errorLock.lock();
    var keyGen = ApiKeyGen.generate();
    return _tokenDio
        .post("api/auth/refresh",
            options: Options(headers: {
              'x-authorization': Application.authKey,
              'authorization': getAuthToken(_csrfToken),
              'time-stamp': keyGen.timeStamp,
              'api-token': keyGen.key,
            }))
        .then((d) async {
      //TODO
      var res = getEntity<RefreshTokenEntity>(d.data);

      if (res.status) {
        //update csrfToken
        _csrfToken = res.token;

        var user = await _appState.getUser();
        user!.token = _csrfToken;
        await _appState.setUser(user);

        options.headers["authorization"] = getAuthToken(_csrfToken);

        _csrfToken = null;
      } else {
        Log.d(TAG, 'Session Expired');
        _csrfToken = null;
        _appState.setAuthState(AuthState.Expired);
        return Future.error('Session Expired');
      }
    }, onError: (error) {
      if (error is DioError && error.type == DioErrorType.response) {
        if (error.response?.statusCode == 401) {
          _appState.setAuthState(AuthState.Expired);
        }
      }
      return error;
    }).whenComplete(() {
      _dio.unlock();
      _dio.interceptors.responseLock.unlock();
      _dio.interceptors.errorLock.unlock();
    }).then((e) {
      if (e is DioError) return e;
      //repeat
      return _dio.request(options.path,
          options: getOptions(options, _csrfToken));
    });
  }

  T getEntity<T>(_json) {
    var res;
    switch (T) {
      case BaseEntity:
        res = BaseEntity.fromJson(_json);
        break;
      case LoginEntity:
        res = LoginEntity.fromJson(_json);
        break;
      case ProfileEntity:
        res = ProfileEntity.fromJson(_json);
        break;
      case RefreshTokenEntity:
        res = RefreshTokenEntity.fromJson(_json);
        break;
      case SongsEntity:
        res = SongsEntity.fromJson(_json);
        break;
      case SongEntity:
        res = SongEntity.fromJson(_json);
        break;
      case BooksEntity:
        res = BooksEntity.fromJson(_json);
        break;
      case BookEntity:
        res = BookEntity.fromJson(_json);
        break;
      case BookGamesEntity:
        res = BookGamesEntity.fromJson(_json);
        break;
      case CurrentBookEntity:
        res = CurrentBookEntity.fromJson(_json);
        break;
      case TermEntity:
        res = TermEntity.fromJson(_json);
        break;
      case DictionaryEntity:
        res = DictionaryEntity.fromJson(_json);
        break;
      default:
        throw ('$T Not implemented');
    }

    return res;
  }
}
