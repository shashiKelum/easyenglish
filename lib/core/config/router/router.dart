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

import 'package:easyenglish/ui/views/book/book_view.dart';
import 'package:easyenglish/ui/views/book/views/book_complete_view.dart';
import 'package:easyenglish/ui/views/book/views/book_cover_view.dart';
import 'package:easyenglish/ui/views/book/views/pages/book_pages_view.dart';
import 'package:easyenglish/ui/views/book/views/pages/page/book_page_view.dart';
import 'package:easyenglish/ui/views/book/views/prelude/book_prelude_view.dart';
import 'package:easyenglish/ui/views/dictionary/dictionary_view.dart';
import 'package:easyenglish/ui/views/flashcard/flashcard_view.dart';
import 'package:easyenglish/ui/views/game/complete/game_complete_view.dart';
import 'package:easyenglish/ui/views/game/game/game_view.dart';
import 'package:easyenglish/ui/views/game/game_selection_view.dart';
import 'package:easyenglish/ui/views/level/complete/level_complete_view.dart';
import 'package:easyenglish/ui/views/level/level_view.dart';
import 'package:easyenglish/ui/views/locale/locale_view.dart';
import 'package:easyenglish/ui/views/login/login_view.dart';
import 'package:easyenglish/ui/views/login/views/login_input_view.dart';
import 'package:easyenglish/ui/views/main/dashboard/dashboard_view.dart';
import 'package:easyenglish/ui/views/main/main_view.dart';
import 'package:easyenglish/ui/views/otp/otp_view.dart';
import 'package:easyenglish/ui/views/register/register_view.dart';
import 'package:easyenglish/ui/views/register/views/account_selection_view.dart';
import 'package:easyenglish/ui/views/register/views/input_view.dart';
import 'package:easyenglish/ui/views/register/views/name_view.dart';
import 'package:easyenglish/ui/views/register/views/password_view.dart';
import 'package:easyenglish/ui/views/register/views/verify_email_view.dart';
import 'package:easyenglish/ui/views/splash/splash_view.dart';
import 'package:easyenglish/ui/widgets/dummy_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  AdaptiveRoute(page: SplashView, initial: true),
  AdaptiveRoute(page: LocaleView),
  AdaptiveRoute(page: MainView, children: [
    AdaptiveRoute(page: DashboardView, initial: true),
    AdaptiveRoute(page: DummyView),
  ]),
  AdaptiveRoute(page: LoginView, children: [
    CustomRoute(
      page: LoginInputView,
      initial: true,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: OtpView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
  ]),
  AdaptiveRoute(page: RegisterView, children: [
    CustomRoute(
      page: AccountSelectionView,
      initial: true,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: NameView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: InputView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: VerifyEmailView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: PasswordView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: OtpView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
  ]),
  AdaptiveRoute(page: OtpView),
  AdaptiveRoute(page: BookView, children: [
    CustomRoute(
      page: BookCoverView,
      initial: true,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: BookPreludeView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: BookPagesView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
      children: [
        CustomRoute(
          initial: true,
          page: BookPageView,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        ),
      ],
    ),
    CustomRoute(
      page: BookCompleteView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
  ]),
  AdaptiveRoute(page: FlashcardView),
  AdaptiveRoute(page: GameSelectionView),
  AdaptiveRoute(page: GameView),
  AdaptiveRoute(page: GameCompleteView),
  AdaptiveRoute(page: DictionaryView),
  AdaptiveRoute(page: LevelView),
  AdaptiveRoute(page: LevelCompleteView),
])
class $Router {}
