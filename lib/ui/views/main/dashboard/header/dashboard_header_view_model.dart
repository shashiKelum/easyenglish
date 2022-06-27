import 'package:easyenglish/core/config/router/router.router.dart';
import 'package:easyenglish/core/models/book_entity.dart';
import 'package:easyenglish/core/services/books_service.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardHeaderViewModel extends BaseViewModel {
  static const TAG = 'DashboardHeaderViewModel';
  final NavigationService _navigationService = GetIt.I.get();
  final BooksService _booksService;
  final BehaviorSubject<Book> _bookController = BehaviorSubject();

  DashboardHeaderViewModel(this._booksService) {
    getCurrentBook();
  }

  BehaviorSubject<Book> get book => _bookController;

  void getCurrentBook() {
    _booksService.getCurrentBook().then((value) => _bookController.add(value));
  }
 
  void onTapStart() {
    final res = book.valueOrNull;

    if (res != null)
      _navigationService.navigateTo(Routes.bookView,
          arguments: BookViewArguments(book: res));
  }
}
