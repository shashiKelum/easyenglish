import 'dart:async';

import '../../core/services/api/api.dart';
import '../../core/services/authentication_service.dart';

class CartService {
  final AuthenticationService _authService;
  final Api _api;
  StreamSubscription? _authStateSub;

  // BehaviorSubject<Cart?> _cart = BehaviorSubject<Cart?>();
  //
  // BehaviorSubject<Cart?> get cart => _cart;

  CartService(this._authService, this._api);

  void dispose() {
    // _cart.close();
    // _authStateSub?.cancel();
  }
}
