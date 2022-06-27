// class AuthGuard {
//   static const TAG = 'AuthGuard';
//
//   @override
//   Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
//       Object arguments) async {
//     final state =
//         await Provider.of<AppStateService>(navigator.context, listen: false)
//             .getAuthState();
//     Log.d(TAG, 'canNavigate: AuthState: $state');
//     return state == AuthState.SignedIn;
//   }
// }
