import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../r.g.dart';
import '../../../../ui/theme/color.dart';
import '../../../../ui/theme/dim.dart';

enum DialogType { Info, Error, Success }

extension DialogTypeExtension on DialogType {
  ImageProvider? get image {
    switch (this) {
      case DialogType.Error:
        return R.image.ic_error();

      case DialogType.Success:
        return R.image.ic_success();

      case DialogType.Info:
      default:
        return null;
    }
  }

  Color get color {
    switch (this) {
      case DialogType.Error:
        return AppColors.error;

      case DialogType.Success:
        return AppColors.success;

      case DialogType.Info:
      default:
        return AppColors.info;
    }
  }
}

class DialogMessage<T> extends StatefulWidget {
  final String? title;
  final String message;
  final String positiveText;
  final Function(T)? positiveCallback;
  final String? negativeText;
  final Function(T)? negativeCallback;
  final T? extra;
  final DialogType type;
  final bool autoDismiss;

  const DialogMessage(
      {Key? key,
      this.title,
      required this.message,
      this.positiveText = 'OK',
      this.positiveCallback,
      this.negativeText,
      this.negativeCallback,
      this.extra,
      this.type = DialogType.Info,
      this.autoDismiss = false})
      : super(key: key);

  @override
  _DialogMessageState createState() => _DialogMessageState();
}

class _DialogMessageState extends State<DialogMessage> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: _dialogBody(context),
    );
  }

  _dialogBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: widget.type != DialogType.Info ? 42.0 : 16.0,
              ),
              padding: EdgeInsets.only(
                top: AppDim.size16,
                bottom: AppDim.size16,
                left: AppDim.size16,
                right: AppDim.size16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: _bodyContent(),
            ),
            if (widget.type != DialogType.Info)
              Image(image: widget.type.image!),
          ],
        ),
      ],
    );
  }

  _bodyContent() {
    return Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (widget.type != DialogType.Info) SizedBox(height: 24.0),
        _title(),
        _message(),
        SizedBox(height: AppDim.size24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: widget.negativeText == null ? 0 : 1,
              child: buildNegativeButton(),
            ),
            SizedBox(width: 8.0),
            Expanded(
              flex: widget.negativeText == null ? 0 : 1,
              child: buildPositiveButton(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _title() {
    if (widget.title == null)
      return Container();
    else
      return Column(
        children: <Widget>[
          Text(
            widget.title!,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                color: widget.negativeText != null &&
                        widget.type == DialogType.Info
                    ? AppColors.error
                    : widget.type.color),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDim.size16),
        ],
      );
  }

  Widget _message() {
    return widget.message == null
        ? Container()
        : Text(
            widget.message,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: AppColors.gray3),
            textAlign: TextAlign.center,
          );
  }

  Widget buildPositiveButton() {
    return SizedBox(
      height: 36.0,
      child: FlatButton(
        color:
            widget.negativeText != null ? AppColors.error : widget.type.color,
        child: Text(
          widget.positiveText,
          style:
              Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
        ),
        onPressed: () {
          if (widget.positiveCallback == null)
            Navigator.pop(context, widget.extra);
          else {
            if (widget.autoDismiss) Navigator.pop(context, widget.extra);
            widget.positiveCallback!(widget.extra);
          }
        },
      ),
    );
  }

  Widget buildNegativeButton() {
    if (widget.negativeText == null) return Container();

    return SizedBox(
      height: 36.0,
      child: FlatButton(
        color: AppColors.success,
        child: Text(
          widget.negativeText ?? 'CANCEL',
          style:
              Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
        ),
        onPressed: () {
          if (widget.negativeCallback == null)
            Navigator.pop(context, widget.extra);
          else
            widget.negativeCallback!(widget.extra);
        },
      ),
    );
  }
}
