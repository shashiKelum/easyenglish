import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:flutter/material.dart';

enum Language { English, Sinhala, Tamil }

extension LanguageExtension on Language {
  String get name {
    switch (this) {
      case Language.English:
        return LocaleKeys.langs_english;
      case Language.Sinhala:
        return LocaleKeys.langs_sinhala;
      case Language.Tamil:
        return LocaleKeys.langs_tamil;
    }
  }

  Locale get locale {
    switch (this) {
      case Language.English:
        return Locale('en', 'US');
      case Language.Sinhala:
        return Locale('si', 'SL');
      case Language.Tamil:
        return Locale('ta', 'SL');
    }
  }
}
