import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';

import 'dialogs/dialog_auth_provider_picker.dart';
import 'dialogs/dialog_image_picker.dart';
import 'dialogs/dialog_list.dart';
import 'dialogs/dialog_list_item.dart';
import 'dialogs/dialog_message.dart';
import 'dialogs/dialog_photo.dart';

class DialogService {
  final NavigationService navigationService = GetIt.I<NavigationService>();

  Future message(
    String? message, {
    String? title,
    DialogType type = DialogType.Info,
    String positiveButtonText = 'OK',
    Function(dynamic val)? positiveCallback,
    bool dismissible = true,
    bool autoDismiss = false,
  }) {
    return showDialog(
      context: StackedService.navigatorKey!.currentState!.context,
      barrierDismissible: dismissible,
      builder: (context) => DialogMessage(
        message: message!,
        title: title,
        type: type,
        positiveCallback: positiveCallback,
        positiveText: positiveButtonText,
        autoDismiss: autoDismiss,
      ),
    );
  }

  Future imagePicker(void Function(ImageSource source) callback) {
    return showDialog(
      context: StackedService.navigatorKey!.currentState!.context,
      builder: (context) => DialogImagePicker(callback: callback),
    );
  }

  Future<String?> authProviderPicker({
    required List<String> providerIds,
    Function(String providerId)? callback,
    String? message,
    bool dismissible = false,
  }) async {
    return await showDialog<String>(
      context: StackedService.navigatorKey!.currentState!.context,
      barrierDismissible: dismissible,
      builder: (context) => DialogAuthProviderPicker(
          message: message,
          dismissible: dismissible,
          providerIds: providerIds,
          callback: callback),
    );
  }

  Future confirm(
    String message, {
    String? title,
    String positiveButtonText = 'Yes',
    String negativeButtonText = 'No',
    Function(dynamic val)? positiveCallback,
    Function(dynamic val)? negativeCallBack,
    DialogType type = DialogType.Info,
    bool dismissible = true,
    bool autoDismiss = false,
  }) {
    return showDialog(
      context: StackedService.navigatorKey!.currentState!.context,
      barrierDismissible: dismissible,
      builder: (context) => DialogMessage(
        message: message,
        title: title,
        positiveText: positiveButtonText,
        negativeText: negativeButtonText,
        positiveCallback: positiveCallback,
        negativeCallback: negativeCallBack,
        type: type,
        autoDismiss: autoDismiss,
      ),
    );
  }

  Future list<T>({
    required String title,
    required List<DialogListItem<T>> items,
  }) {
    return showDialog(
        context: StackedService.navigatorKey!.currentState!.context,
        builder: (context) => DialogList(
              title: title,
              items: items,
            ));
  }

  Future checkList<T>({
    required String title,
    required List<DialogListItem<T>> items,
  }) {
    return showDialog(
        context: StackedService.navigatorKey!.currentState!.context,
        builder: (context) => DialogList(
              title: title,
              items: items,
            ));
  }

  ScaffoldFeatureController showSnackBar(
    String message, {
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    Duration duration = const Duration(milliseconds: 4000),
  }) {
    return ScaffoldMessenger.of(
            StackedService.navigatorKey!.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: style,
          textAlign: textAlign,
          softWrap: softWrap,
          overflow: overflow,
          maxLines: maxLines,
        ),
        duration: duration,
      ),
    );
  }

  Future photo(String url) {
    return showDialog(
      context: StackedService.navigatorKey!.currentState!.context,
      builder: (context) => DialogPhoto(url: url),
    );
  }
}
