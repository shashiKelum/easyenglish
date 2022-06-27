import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BackgroundProgress<T> extends ViewModelWidget<T> {
  final Widget child;

  BackgroundProgress({required this.child});

  @override
  Widget build(BuildContext context, T model) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 2000),
      child: Stack(
        children: [
          child,
          if ((model as BaseViewModel).isBusy)
            AnimatedOpacity(
              opacity: model.isBusy ? 1 : 0,
              duration: Duration(milliseconds: 2000),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                  ),
                  // child: Center(
                  //   child: CircularProgressIndicator(
                  //     backgroundColor: AppColors.accent.withOpacity(0.2),
                  //     valueColor: AlwaysStoppedAnimation(AppColors.accent),
                  //     strokeWidth: 3.0,
                  //   ),
                  // ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
