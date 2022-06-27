import 'package:easyenglish/core/enums/language.dart';
import 'package:easyenglish/core/models/dictionary_entity.dart';
import 'package:easyenglish/core/models/term_entity.dart';
import 'package:easyenglish/core/services/app_state_service.dart';
import 'package:easyenglish/core/services/books_service.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DictionaryViewModel extends BaseViewModel {
  final BooksService _booksService;
  final AppStateService _appStateService;
  final NavigationService _navigationService = GetIt.I.get();
  final BehaviorSubject<List<Dictionary>> _controller = BehaviorSubject();
  final AudioPlayer _player = AudioPlayer();

  late Language _language;
  int _selectedDictionaryIndex = 0;
  Term? _selectedTerm;

  DictionaryViewModel(int? bookId, this._booksService, this._appStateService) {
    _appStateService.getLanguage().then((value) => _language = value);

    if (bookId != null)
      _booksService.getDictionary(bookId).then(
          (value) => _controller.add(value),
          onError: (error) => _controller.addError(error));
  }

  Language get language => _language;

  BehaviorSubject<List<Dictionary>> get dictionary => _controller;

  int get selectedDictionaryIndex => _selectedDictionaryIndex;

  set selectedDictionaryIndex(int selectedIndex) {
    _selectedDictionaryIndex = selectedIndex;
    notifyListeners();
  }

  Term? get selectedTerm => _selectedTerm;

  set selectedTerm(Term? selectedTerm) {
    _selectedTerm = selectedTerm;
    notifyListeners();
  }

  void onClickBack() => _navigationService.back();

  onTapDictionary(int index) => selectedDictionaryIndex = index;

  onTapTerm(Term term) {
    selectedTerm = term;
  }

  onTapSpeaker(Term? term) async {
    if(term?.audioPath?.isNotEmpty ?? false) {
      await _player.setUrl(term!.audioPath!);
      await _player.play();
    }
  }

  Future<Term> getTerm(Term term) async {
    return await _booksService.downloadTerm(term);
  }
}
