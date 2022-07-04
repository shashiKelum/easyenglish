import 'package:flutter/material.dart';
import 'package:easyenglish/assets/l10n/l10n.dart';
import 'package:easyenglish/provider/locale_provider.dart';
import 'package:provider/provider.dart';



class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
