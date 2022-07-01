import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('si'),
    const Locale('ta'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'si':
        return 'SL';
      case 'ta':
        return 'SL';      
      case 'en':
      default:
        return '🇺🇸';
    }
  }
}
