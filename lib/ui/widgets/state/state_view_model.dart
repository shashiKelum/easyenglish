import 'package:stacked/stacked.dart';

import '../../../core/enums/auth_state.dart';
import '../../../core/services/authentication_service.dart';

class StateViewModel extends BaseViewModel {
  final AuthenticationService _authService;

  StateViewModel(this._authService);

  void login() async {
    if (_authService.authState.valueOrNull != null &&
        _authService.authState.value == AuthState.Expired) {
      setBusy(true);
      await _authService.logout();
      setBusy(false);
    }

    // ExtendedNavigator.root.push(Routes.loginView);
  }
}
