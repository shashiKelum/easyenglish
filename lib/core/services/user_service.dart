import '../../core/services/api/api.dart';
import '../../core/services/authentication_service.dart';

class UserService {
  final Api _api;
  final AuthenticationService _authService;

  UserService(this._api, this._authService);
}
