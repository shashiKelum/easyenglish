import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final String buttonText;
  final void Function()? onTap;

  const ErrorView(
      {Key? key,
      required this.message,
      this.buttonText = 'Go Back',
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(message, textAlign: TextAlign.center),
          if (onTap != null)
            OutlinedButton(
              onPressed: onTap,
              child: Text(buttonText),
            ),
        ],
      ),
    );
  }
}
