import 'package:flutter/material.dart';

class ProgressButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isBusy;

  const ProgressButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: isBusy
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                backgroundColor: Colors.white30,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : Text(text),
      onPressed: isBusy ? null : onPressed,
    );
  }
}
