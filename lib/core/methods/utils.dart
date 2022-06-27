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
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:easyenglish/core/config/application.dart';
import 'package:easyenglish/core/config/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';

class Utils {
  static const TAG = 'Utils';

  static String? getProfileImageNameDecorator(String? name) {
    return name?.substring(0, 2);
  }

  static double getCubic(num width, num height, num length) {
    return (width * height * length).roundToDouble();
  }

  static num convertCubicInchesToCubicCentimeters(num cubInches) {
    return (cubInches * 16.387).roundToDouble();
  }

  static num convertCubicCentimetersToCubicInches(num cubCentimeters) {
    return (cubCentimeters / 16.387).roundToDouble();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static DateTime getOpeningAt([DateTime? date]) {
    var d = date == null ? DateTime.now() : date;
    return DateTime(d.year, d.month, d.day, 11, 0);
  }

  static DateTime getClosingAt([DateTime? date]) {
    var d = date == null ? DateTime.now() : date;
    return DateTime(d.year, d.month, d.day, 23, 0);
  }

  static DateTime roundWithinXMinutes(DateTime d, Duration interval) {
    int minutes =
        ((d.minute / interval.inMinutes).round() * interval.inMinutes).round();
    Log.d(TAG, '$minutes', references: ['roundWithinXMinutes']);
    return DateTime(d.year, d.month, d.day)
        .add(Duration(hours: d.hour, minutes: minutes));
  }

  static Future<String> toBase64(File file) async {
    List fileBytes = await file.readAsBytes();
    return base64.encode(fileBytes as List<int>);
  }

  static String getImageUrl(String? photo) {
    if (photo == null || photo.isEmpty) return '';
    try {
      final uri = Uri.parse(photo);
      if (uri.hasScheme)
        return photo;
      else
        return Application.imageBaseUrl + photo;
    } on FormatException catch (ex) {
      Log.e(TAG, ex.message, references: ['getImageUrl'], exception: ex);
    }
    return '';
  }

  static String getError(List<String>? error) {
    if (error != null && error.length > 0)
      return error.join(' ');
    else
      return ErrorMessages.SOMETHING_WENT_WRONG;
  }

  static Widget imageError(context, error, stackTrace) {
    return Center(child: Icon(Icons.broken_image_outlined));
  }
}
