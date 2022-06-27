import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../core/enums/auth_state.dart';
import '../../../core/services/app_state_service.dart';
import '../../../ui/widgets/progress/background_progress.dart';
import '../../../ui/widgets/state/state_view_model.dart';

class StateView extends StatelessWidget {
  static const String TAG = 'StateView';

  final Widget? child;
  final List<AuthState>? minimumRequiredStates;
  final String? minimumStateMessage;
  final bool showOnStatesGranted;

  const StateView(
      {Key? key,
      this.child,
      this.minimumRequiredStates,
      this.minimumStateMessage,
      this.showOnStatesGranted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StateViewModel>.reactive(
      viewModelBuilder: () => StateViewModel(Provider.of(context)),
      builder: (context, model, child) {
        return BackgroundProgress<StateViewModel>(
          child: StreamBuilder<AuthState>(
            stream:
                Provider.of<AppStateService>(context, listen: false).authState,
            builder: (BuildContext context, AsyncSnapshot<AuthState> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());

                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData && snapshot.data == AuthState.Expired ||
                      !(minimumRequiredStates != null &&
                          minimumRequiredStates!
                                  .where((element) => element == snapshot.data)
                                  .toList()
                                  .length ==
                              1)) {
                    return Stack(
                      children: [
                        if (!showOnStatesGranted)
                          Positioned.fill(child: this.child!),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black12,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      minimumStateMessage ??
                                          'Your session has been expired.\nPlease login again.',
                                      textAlign: TextAlign.center,
                                      // style: AppStyle.textStateMessage,
                                    ),
                                    SizedBox(height: 16.0),
                                    ElevatedButton(
                                      onPressed: model.login,
                                      child: Text('Login'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return this.child!;
                  }
              }
            },
          ),
        );
      },
    );
  }
}
