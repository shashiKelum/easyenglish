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

import 'package:easyenglish/ui/theme/styles.dart';
import 'package:flutter/material.dart';

import '../../r.g.dart';
import '../theme/color.dart';

class AppTheme {
  static ThemeData get theme {
    final base = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSurface: Colors.red,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: R.fontFamily.ciutadella_rounded,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        centerTitle: false,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: AppColors.gray1,
        ),
        color: AppColors.appbarBackground,
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.withOpacity(0.6),
        selectionHandleColor: AppColors.primary,
      ),
      inputDecorationTheme: AppTheme.inputDecorationThemeOutline,
      // tabBarTheme: TabBarTheme(
      //   labelColor: AppColors.text1,
      //   unselectedLabelColor: AppColors.accent,
      //   indicator: BoxDecoration(
      //       border: Border(bottom: BorderSide(color: AppColors.text1))),
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     minimumSize: Size.fromHeight(50),
      //   ),
      // ),
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     primary: AppColors.accent,
      //   ),
      // ),
      // outlinedButtonTheme: OutlinedButtonThemeData(
      //   style: OutlinedButton.styleFrom(
      //     side: BorderSide(color: AppColors.accent, width: 1),
      //   ),
      // ),
      // buttonTheme: ButtonThemeData(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(AppDim.buttonBorderRadius),
      //   ),
      //   buttonColor: Colors.black,
      //   height: 50.0,
      //   textTheme: ButtonTextTheme.primary,
      //   disabledColor: AppColors.disabled,
      // ),
      // chipTheme: base.chipTheme.copyWith(
      //   backgroundColor: AppColors.primaryBlue,
      //   deleteIconColor: AppColors.accent,
      // ),
      // toggleableActiveColor: AppColors.accent,
      // toggleButtonsTheme: base.toggleButtonsTheme.copyWith(
      //   borderRadius: BorderRadius.circular(5.0),
      //   selectedColor: Colors.white,
      //   selectedBorderColor: AppColors.accent,
      //   fillColor: AppColors.accent,
      //   textStyle: TextStyle(
      //     fontSize: 16.0,
      //     color: Colors.black,
      //     fontWeight: FontWeight.w500,
      //   ),
      // ),
      radioTheme: RadioThemeData(
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //   backgroundColor: Colors.white,
      //   foregroundColor: AppColors.accent,
      // ),
    );
  }

  static InputDecorationTheme get inputDecorationThemeUnderline =>
      InputDecorationTheme(
        isDense: true,
        labelStyle: TextStyle(
          color: AppColors.textFieldLabel,
        ),
        hintStyle: TextStyle(
          color: AppColors.textFieldHint,
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
        ),
        errorStyle: TextStyle(
          color: AppColors.textFieldError,
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
        ),
        focusColor: AppColors.textFieldFocused,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldNormal),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldNormal),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldFocused),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldError),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldError, width: 2.0),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldDisabled),
        ),
      );

  static InputDecorationTheme get inputDecorationThemeOutline =>
      InputDecorationTheme(
        filled: true,
        isDense: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: AppColors.textFieldLabel,
        ),
        hintStyle: AppStyle.text18SB.copyWith(
          color: AppColors.textPrimary.withOpacity(0.2),
        ),
        errorStyle: AppStyle.text14R.copyWith(color: AppColors.textFieldError),
        focusColor: AppColors.textFieldFocused,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldNormal, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldNormal, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldFocused, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldError, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldError, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldDisabled, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      );
}
