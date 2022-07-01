import 'package:easyenglish/generated/codegen_loader.g.dart';
import 'package:easyenglish/provider/locale_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Language { English, Sinhala, Tamil }



extension LanguageExtension on Language {
  String get name {
    switch (this) {
      case Language.English:      
        return 'English';
      case Language.Sinhala:
        return 'සිංහල';
      case Language.Tamil:
        return 'தமிழ்';
    }
  }

  Locale get locale {
    switch (this) {
      case Language.English:
        return Locale('en');
      case Language.Sinhala:
        return Locale('si');
      case Language.Tamil:
        return Locale('ta');
    }
    
  }
}
