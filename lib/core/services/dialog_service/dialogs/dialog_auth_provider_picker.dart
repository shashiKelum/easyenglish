import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../ui/theme/color.dart';
import '../../../../ui/theme/dim.dart';

class DialogAuthProviderPicker extends StatefulWidget {
  final Function(String providerId)? callback;
  final List<String> providerIds;
  final String? message;
  final bool dismissible;

  const DialogAuthProviderPicker(
      {Key? key,
      required this.providerIds,
      this.callback,
      this.message,
      this.dismissible = false})
      : assert(providerIds != null && providerIds.length > 0),
        super(key: key);

  @override
  _DialogAuthProviderPickerState createState() =>
      _DialogAuthProviderPickerState();
}

class _DialogAuthProviderPickerState extends State<DialogAuthProviderPicker> {
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
        Container(
          margin: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
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
      ],
    );
  }

  Widget _bodyContent() {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.message != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                widget.message!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: AppColors.gray3),
                textAlign: TextAlign.center,
              ),
            ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runAlignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              if (widget.providerIds.contains(FacebookAuthProvider.PROVIDER_ID))
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebookF),
                    onPressed: () =>
                        _handleClick(FacebookAuthProvider.PROVIDER_ID)),
              if (widget.providerIds.contains(GoogleAuthProvider.PROVIDER_ID))
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.googlePlusG),
                    onPressed: () =>
                        _handleClick(GoogleAuthProvider.PROVIDER_ID)),
              if (widget.providerIds.contains('apple.com'))
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.apple),
                    onPressed: () => _handleClick('apple.com')),
            ],
          ),
          if (widget.dismissible)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AppColors.primary),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handleClick(String provider) {
    if (widget.callback != null)
      widget.callback!(provider);
    else
      Navigator.pop(context, provider);
  }
}
