// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../ui/views/book/book_view.dart';
import '../../../ui/views/book/views/book_complete_view.dart';
import '../../../ui/views/book/views/book_cover_view.dart';
import '../../../ui/views/book/views/pages/book_pages_view.dart';
import '../../../ui/views/book/views/pages/page/book_page_view.dart';
import '../../../ui/views/book/views/prelude/book_prelude_view.dart';
import '../../../ui/views/dictionary/dictionary_view.dart';
import '../../../ui/views/flashcard/flashcard_view.dart';
import '../../../ui/views/game/complete/game_complete_view.dart';
import '../../../ui/views/game/game/game_view.dart';
import '../../../ui/views/game/game_selection_view.dart';
import '../../../ui/views/level/complete/level_complete_view.dart';
import '../../../ui/views/level/level_view.dart';
import '../../../ui/views/locale/locale_view.dart';
import '../../../ui/views/login/login_view.dart';
import '../../../ui/views/login/views/login_input_view.dart';
import '../../../ui/views/main/dashboard/dashboard_view.dart';
import '../../../ui/views/main/main_view.dart';
import '../../../ui/views/otp/otp_view.dart';
import '../../../ui/views/register/register_view.dart';
import '../../../ui/views/register/views/account_selection_view.dart';
import '../../../ui/views/register/views/input_view.dart';
import '../../../ui/views/register/views/name_view.dart';
import '../../../ui/views/register/views/password_view.dart';
import '../../../ui/views/register/views/verify_email_view.dart';
import '../../../ui/views/splash/splash_view.dart';
import '../../../ui/widgets/dummy_view.dart';
import '../../enums/game_type.dart';
import '../../enums/otp_verification_method.dart';
import '../../models/book_entity.dart';
import '../../models/otp_data_entity.dart';
import '../../models/term_entity.dart';

class Routes {
  static const String splashView = '/';
  static const String localeView = '/locale-view';
  static const String mainView = '/main-view';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String otpView = '/otp-view';
  static const String bookView = '/book-view';
  static const String flashcardView = '/flashcard-view';
  static const String gameSelectionView = '/game-selection-view';
  static const String gameView = '/game-view';
  static const String gameCompleteView = '/game-complete-view';
  static const String dictionaryView = '/dictionary-view';
  static const String levelView = '/level-view';
  static const String levelCompleteView = '/level-complete-view';
  static const all = <String>{
    splashView,
    localeView,
    mainView,
    loginView, 
    registerView,
    otpView,
    bookView,
    flashcardView,
    gameSelectionView,
    gameView,
    gameCompleteView,
    dictionaryView,
    levelView,
    levelCompleteView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.localeView, page: LocaleView),
    RouteDef(
      Routes.mainView,
      page: MainView,
      generator: MainViewRouter(),
    ),
    RouteDef(
      Routes.loginView,
      page: LoginView,
      generator: LoginViewRouter(),
    ),
    RouteDef(
      Routes.registerView,
      page: RegisterView,
      generator: RegisterViewRouter(),
    ),
    RouteDef(Routes.otpView, page: OtpView),
    RouteDef(
      Routes.bookView,
      page: BookView,
      generator: BookViewRouter(),
    ),
    RouteDef(Routes.flashcardView, page: FlashcardView),
    RouteDef(Routes.gameSelectionView, page: GameSelectionView),
    RouteDef(Routes.gameView, page: GameView),
    RouteDef(Routes.gameCompleteView, page: GameCompleteView),
    RouteDef(Routes.dictionaryView, page: DictionaryView),
    RouteDef(Routes.levelView, page: LevelView),
    RouteDef(Routes.levelCompleteView, page: LevelCompleteView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    LocaleView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LocaleView(),
        settings: data,
      );
    },
    MainView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => MainView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    RegisterView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RegisterView(),
        settings: data,
      );
    },
    OtpView: (data) {
      var args = data.getArgs<OtpViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OtpView(
          args.verificationMethod,
          args.data,
        ),
        settings: data,
      );
    },
    BookView: (data) {
      var args = data.getArgs<BookViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => BookView(args.book),
        settings: data,
      );
    },
    FlashcardView: (data) {
      var args = data.getArgs<FlashcardViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => FlashcardView(
          key: args.key,
          termId: args.termId,
        ),
        settings: data,
      );
    },
    GameSelectionView: (data) {
      var args = data.getArgs<GameSelectionViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => GameSelectionView(args.book),
        settings: data,
      );
    },
    GameView: (data) {
      var args = data.getArgs<GameViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => GameView(
          args.bookId,
          args.bookLevel,
          args.gameType,
          args.game,
        ),
        settings: data,
      );
    },
    GameCompleteView: (data) {
      var args = data.getArgs<GameCompleteViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => GameCompleteView(
          key: args.key,
          title: args.title,
          buttonText: args.buttonText,
          level: args.level,
        ),
        settings: data,
      );
    },
    DictionaryView: (data) {
      var args = data.getArgs<DictionaryViewArguments>(
        orElse: () => DictionaryViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DictionaryView(
          key: args.key,
          bookId: args.bookId,
        ),
        settings: data,
      );
    },
    LevelView: (data) {
      var args = data.getArgs<LevelViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LevelView(
          key: args.key,
          level: args.level,
          unit: args.unit,
        ),
        settings: data,
      );
    },
    LevelCompleteView: (data) {
      var args = data.getArgs<LevelCompleteViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LevelCompleteView(
          key: args.key,
          level: args.level,
          unit: args.unit,
        ),
        settings: data,
      );
    },
  };
}

class MainViewRoutes {
  static const String dashboardView = '/';
  static const String dummyView = '/dummy-view';
  static const all = <String>{
    dashboardView,
    dummyView,
  };
}

class MainViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(MainViewRoutes.dashboardView, page: DashboardView),
    RouteDef(MainViewRoutes.dummyView, page: DummyView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    DashboardView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DashboardView(),
        settings: data,
      );
    },
    DummyView: (data) {
      var args = data.getArgs<DummyViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DummyView(
          key: args.key,
          name: args.name,
        ),
        settings: data,
      );
    },
  };
}

class LoginViewRoutes {
  static const String loginInputView = '/';
  static const String otpView = '/otp-view';
  static const all = <String>{
    loginInputView,
    otpView,
  };
}

class LoginViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(LoginViewRoutes.loginInputView, page: LoginInputView),
    RouteDef(LoginViewRoutes.otpView, page: OtpView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LoginInputView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LoginInputView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    OtpView: (data) {
      var args = data.getArgs<OtpViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => OtpView(
          args.verificationMethod,
          args.data,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
  };
}

class RegisterViewRoutes {
  static const String accountSelectionView = '/';
  static const String nameView = '/name-view';
  static const String inputView = '/input-view';
  static const String verifyEmailView = '/verify-email-view';
  static const String passwordView = '/password-view';
  static const String otpView = '/otp-view';
  static const all = <String>{
    accountSelectionView,
    nameView,
    inputView,
    verifyEmailView,
    passwordView,
    otpView,
  };
}

class RegisterViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(RegisterViewRoutes.accountSelectionView,
        page: AccountSelectionView),
    RouteDef(RegisterViewRoutes.nameView, page: NameView),
    RouteDef(RegisterViewRoutes.inputView, page: InputView),
    RouteDef(RegisterViewRoutes.verifyEmailView, page: VerifyEmailView),
    RouteDef(RegisterViewRoutes.passwordView, page: PasswordView),
    RouteDef(RegisterViewRoutes.otpView, page: OtpView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    AccountSelectionView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AccountSelectionView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    NameView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => NameView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    InputView: (data) {
      var args = data.getArgs<InputViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            InputView(isEmail: args.isEmail),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    VerifyEmailView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            VerifyEmailView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    PasswordView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => PasswordView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    OtpView: (data) {
      var args = data.getArgs<OtpViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => OtpView(
          args.verificationMethod,
          args.data,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
  };
}

class BookViewRoutes {
  static const String bookCoverView = '/';
  static const String bookPreludeView = '/book-prelude-view';
  static const String bookPagesView = '/book-pages-view';
  static const String bookCompleteView = '/book-complete-view';
  static const all = <String>{
    bookCoverView,
    bookPreludeView,
    bookPagesView,
    bookCompleteView,
  };
}

class BookViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(BookViewRoutes.bookCoverView, page: BookCoverView),
    RouteDef(BookViewRoutes.bookPreludeView, page: BookPreludeView),
    RouteDef(
      BookViewRoutes.bookPagesView,
      page: BookPagesView,
      generator: BookPagesViewRouter(),
    ),
    RouteDef(BookViewRoutes.bookCompleteView, page: BookCompleteView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    BookCoverView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BookCoverView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    BookPreludeView: (data) {
      var args = data.getArgs<BookPreludeViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BookPreludeView(
          args.preludes,
          key: args.key,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    BookPagesView: (data) {
      var args = data.getArgs<BookPagesViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BookPagesView(args.book),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
    BookCompleteView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BookCompleteView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
  };
}

class BookPagesViewRoutes {
  static const String bookPageView = '/';
  static const all = <String>{
    bookPageView,
  };
}

class BookPagesViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(BookPagesViewRoutes.bookPageView, page: BookPageView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    BookPageView: (data) {
      var args = data.getArgs<BookPageViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => BookPageView(
          args.index,
          args.page,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// OtpView arguments holder class
class OtpViewArguments {
  final OtpVerificationMethod verificationMethod;
  final OtpDataEntity data;
  OtpViewArguments({required this.verificationMethod, required this.data});
}

/// BookView arguments holder class
class BookViewArguments {
  final Book book;
  BookViewArguments({required this.book});
}

/// FlashcardView arguments holder class
class FlashcardViewArguments {
  final Key? key;
  final int termId;
  FlashcardViewArguments({this.key, required this.termId});
}

/// GameSelectionView arguments holder class
class GameSelectionViewArguments {
  final Book book;
  GameSelectionViewArguments({required this.book});
}

/// GameView arguments holder class
class GameViewArguments {
  final int bookId;
  final int bookLevel;
  final GameType gameType;
  final dynamic game;
  GameViewArguments(
      {required this.bookId,
      required this.bookLevel,
      required this.gameType,
      required this.game});
}

/// GameCompleteView arguments holder class
class GameCompleteViewArguments {
  final Key? key;
  final String title;
  final String buttonText;
  final int level;
  GameCompleteViewArguments(
      {this.key,
      required this.title,
      required this.buttonText,
      required this.level});
}

/// DictionaryView arguments holder class
class DictionaryViewArguments {
  final Key? key;
  final int? bookId;
  DictionaryViewArguments({this.key, this.bookId});
}

/// LevelView arguments holder class
class LevelViewArguments {
  final Key? key;
  final int level;
  final int unit;
  LevelViewArguments({this.key, required this.level, required this.unit});
}

/// LevelCompleteView arguments holder class
class LevelCompleteViewArguments {
  final Key? key;
  final int level;
  final int unit;
  LevelCompleteViewArguments(
      {this.key, required this.level, required this.unit});
}

/// DummyView arguments holder class
class DummyViewArguments {
  final Key? key;
  final String name;
  DummyViewArguments({this.key, required this.name});
}

/// InputView arguments holder class
class InputViewArguments {
  final bool isEmail;
  InputViewArguments({required this.isEmail});
}

/// BookPreludeView arguments holder class
class BookPreludeViewArguments {
  final List<Term> preludes;
  final Key? key;
  BookPreludeViewArguments({required this.preludes, this.key});
}

/// BookPagesView arguments holder class
class BookPagesViewArguments {
  final Book book;
  BookPagesViewArguments({required this.book});
}

/// BookPageView arguments holder class
class BookPageViewArguments {
  final int index;
  final BookPage page;
  BookPageViewArguments({required this.index, required this.page});
}
