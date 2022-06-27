/*
 * Copyright 2021 CeylonCodeLabs. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';

import 'package:easyenglish/core/config/error_messages.dart';
import 'package:easyenglish/core/enums/auth_provider_type.dart';
import 'package:easyenglish/core/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';
import 'package:get_it/get_it.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/enums/auth_state.dart';
import '../../core/enums/otp_verification_status.dart';
import '../../core/models/otp_verification_entity.dart';
import '../../core/models/user.dart';
import '../../core/services/analytics_service.dart';
import '../../core/services/api/api.dart';
import '../../core/services/app_state_service.dart';
import '../../core/services/dialog_service/dialog_service.dart' as ds;
import '../../core/services/messaging_service.dart';

class AuthenticationService {
  static const String TAG = 'AuthenticationService';
  final AppStateService _appState;
  final Api _api;
  final MessagingService _messagingService;
  final ds.DialogService _dialogService;
  final NavigationService _navigationService = GetIt.I.get();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService;
  final AnalyticsService _analyticsService = GetIt.I();
  final _otpWaiting = OTPVerificationEntity(
    status: OTPVerificationStatus.Waiting,
  );

  AuthenticationService(this._appState, this._api, this._databaseService,
      this._messagingService, this._dialogService);

  BehaviorSubject<AuthState> get authState => _appState.authState;

  BehaviorSubject<AppUser?> get user => _appState.user;

  BehaviorSubject<OTPVerificationEntity> _otpController = BehaviorSubject();

  BehaviorSubject<OTPVerificationEntity> get otpController => _otpController;

  OTPVerificationEntity get optVerificationData => otpController.value;

  Future<bool> _setAuthState(AuthState state) async {
    return await _appState.setAuthState(state);
  }

  Future<AuthState?> _getAuthState() async {
    return _appState.authState.hasValue
        ? _appState.authState.value
        : await _appState.getAuthState();
  }

  Future<bool> setUser(AppUser? user) async {
    return await _appState.setUser(user);
  }

  Future<AppUser?> getUser() async {
    try {
      return _appState.user.hasValue
          ? _appState.user.valueOrNull
          : await _appState.getUser();
    } catch (e) {
      Log.e(TAG, '$e', references: ['getUser']);
      return null;
    }
  }

  // ///
  // /// ## If the [authProviderType] is null,
  // /// Then it's a normal authentication based on the **[identifier] number**
  // /// which needs **OTP** verification, means it falls under [PhoneAuthProvider.PROVIDER_ID]
  // /// authentication flow.
  // /// ##
  // /// ## If the [authProviderType] is mobile,
  // /// Then the mobile number is already verified,
  // /// no need to worry about the email since it's not authenticated.
  // /// ##
  // /// ## If [authProviderType] is social authentication means via [identifier],
  // ///
  // /// * check if [identifier] exists,
  // /// * if not, then no issues continue the flow
  // /// * if yes, then check [authProviderType] is exists
  // /// * if not, then continue the flow
  // /// * if yes, check [identifier] identifier is the same
  // /// * if yes, then continue the flow
  // /// * if not, ERROR => mobile number already associated with another account
  // ///
  // Future<AppUser> authenticate(
  //     {required AuthProviderType authProviderType, String? identifier}) async {
  //   Log.d(TAG, 'providerId: $authProviderType, mobile: $identifier',
  //       references: ['authenticate']);
  //
  //   if (authProviderType == AuthProviderType.Phone &&
  //       (identifier?.isEmpty ?? true))
  //     return Future.error(
  //         'Mobile number cannot be empty or null when auth provider is ${authProviderType.id}');
  //
  //   switch (authProviderType) {
  //     case AuthProviderType.Phone:
  //
  //       /// will continue with mobile otp verification
  //       final credential = await _navigationService.navigateTo(Routes.otpView,
  //           arguments: OtpViewArguments(
  //               verificationMethod: OtpVerificationMethod.Login,
  //               data: OtpDataEntity(mobile: identifier!)));
  //
  //       if (credential != null && credential is PhoneAuthCredential) {
  //         return _signInWithCredential(credential).then((cred) async {
  //           return _saveUser(cred, authProviderType);
  //         }, onError: (error) {
  //           return Future.error('$error');
  //         });
  //       } else {
  //         return Future.error('Not Authenticated');
  //       }
  //       break;
  //     case AuthProviderType.Google:
  //       // TODO: Handle this case.
  //       break;
  //     case AuthProviderType.Facebook:
  //       // TODO: Handle this case.
  //       break;
  //     case AuthProviderType.Apple:
  //       // TODO: Handle this case.
  //       break;
  //   }
  //
  //   return Future.error(ErrorMessages.UNEXPECTED_ERROR_OCCURRED);
  // }

  Future logout() async {
    Log.d(TAG, 'logout');
    await _auth.signOut();
    await setUser(null);
    await _setAuthState(AuthState.None);
  }

  void verifyMobileNumber(String mobile,
      {int? resendToken, Function(OTPVerificationEntity event)? callback}) {
    Log.d(TAG, 'verifyMobileNumber: $mobile, $resendToken');

    if (callback != null) callback(_otpWaiting);
    _otpController.add(_otpWaiting);

    _auth.verifyPhoneNumber(
      forceResendingToken: resendToken,
      phoneNumber: mobile,
      verificationCompleted: (PhoneAuthCredential credential) {
        Log.d(TAG, 'verificationCompleted');
        var data = OTPVerificationEntity(
          status: OTPVerificationStatus.Completed,
          credential: credential,
          otpMessage: 'Authenticating...',
        );
        if (callback != null) callback(data);
        _otpController.add(data);
      },
      verificationFailed: (FirebaseAuthException e) {
        Log.e(TAG, 'verificationFailed', exception: e);
        var data = OTPVerificationEntity(
          status: OTPVerificationStatus.Failed,
          message: (e.code == 'invalid-phone-number')
              ? 'Please enter a valid mobile number'
              : e.message,
        );
        if (callback != null) callback(data);
        _otpController.add(data);
      },
      codeSent: (String verificationId, int? resendToken) {
        Log.d(TAG,
            'codeSent => verificationId: $verificationId, resendToken: $resendToken');
        var data = OTPVerificationEntity(
          status: OTPVerificationStatus.CodeSent,
          verificationId: verificationId,
          resendToken: resendToken,
          otpMessage:
              'OTP sent to\n$mobile\nWait for automatic authentication.',
        );
        if (callback != null) callback(data);
        _otpController.add(data);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Log.d(TAG, 'codeAutoRetrievalTimeout');
        var data = OTPVerificationEntity(
          status: OTPVerificationStatus.Timeout,
          verificationId: verificationId,
          otpMessage:
              "We couldn't identify OTP sms automatically or didn't received it within 30 seconds.",
        );
        if (callback != null) callback(data);
        _otpController.add(data);
      },
    );
  }

  // Future<Map<String, dynamic>> _triggerGoogleAuthentication() async {
  //   Log.d(TAG, '_triggerGoogleAuthentication');
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   if (googleUser != null) {
  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //
  //     // Create a new credential
  //     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     ) as GoogleAuthCredential;
  //
  //     // Once signed in, return the UserCredential
  //     return {
  //       'credential': credential,
  //       'displayName': googleUser.displayName,
  //       'email': googleUser.email,
  //       'photoUrl': googleUser.photoUrl,
  //     };
  //   } else {
  //     return Future.error('Google login cancelled.');
  //   }
  // }
  //
  // Future<Map<String, dynamic>> _triggerFacebookAuthentication() async {
  //   Log.d(TAG, '_triggerFacebookAuthentication');
  //   // Trigger the sign-in flow
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   if (result != null) {
  //     var user = await FacebookAuth.instance.getUserData();
  //
  //     // Create a credential from the access token
  //     final FacebookAuthCredential credential =
  //         FacebookAuthProvider.credential(result.accessToken!.token)
  //             as FacebookAuthCredential;
  //
  //     // Once signed in, return the UserCredential
  //     return {
  //       'credential': credential,
  //       'displayName': user['name'],
  //       'email': user['email'],
  //       'photoUrl':
  //           user['picture'] != null ? user['picture']['data']['url'] : null,
  //     };
  //   } else {
  //     return Future.error('Facebook login cancelled.');
  //   }
  // }
  //
  // Future<Map<String, dynamic>> _triggerAppleAuthentication() async {
  //   if (!(await SignInWithApple.isAvailable())) {
  //     return Future.error('Device not support for Apple authentication.');
  //   }
  //
  //   final nonce = _createNonce(32);
  //   return await (Platform.isIOS
  //           ? SignInWithApple.getAppleIDCredential(
  //               scopes: [
  //                 AppleIDAuthorizationScopes.email,
  //                 AppleIDAuthorizationScopes.fullName,
  //               ],
  //               nonce: sha256.convert(utf8.encode(nonce)).toString(),
  //             )
  //           : SignInWithApple.getAppleIDCredential(
  //               scopes: [
  //                 AppleIDAuthorizationScopes.email,
  //                 AppleIDAuthorizationScopes.fullName,
  //               ],
  //               webAuthenticationOptions: WebAuthenticationOptions(
  //                 redirectUri: Uri.parse(
  //                     'https://barnsbury-3f55c.firebaseapp.com/__/auth/handler'),
  //                 clientId: 'com.syncbridge.Barnsbury',
  //               ),
  //               nonce: sha256.convert(utf8.encode(nonce)).toString(),
  //             ))
  //       .then((nativeAppleCred) {
  //     final credential = new OAuthCredential(
  //       providerId: "apple.com",
  //       // MUST be "apple.com"
  //       signInMethod: "oauth",
  //       // MUST be "oauth"
  //       accessToken: nativeAppleCred.identityToken,
  //       // propagate Apple ID token to BOTH accessToken and idToken parameters
  //       idToken: nativeAppleCred.identityToken,
  //       rawNonce: nonce,
  //     );
  //
  //     return {
  //       'credential': credential,
  //       'displayName': nativeAppleCred.givenName,
  //       'email': nativeAppleCred.email,
  //       'photoUrl': null,
  //     };
  //   }, onError: (error) {
  //     if (error is SignInWithAppleNotSupportedException) {
  //       Log.e(TAG, '_triggerAppleAuthentication', exception: error);
  //       throw error.message;
  //     } else if (error is SignInWithAppleAuthorizationException) {
  //       Log.e(TAG, '_triggerAppleAuthentication', exception: error);
  //       switch (error.code) {
  //         case AuthorizationErrorCode.canceled:
  //           throw 'Apple login cancelled.';
  //         case AuthorizationErrorCode.failed:
  //           throw 'Authentication failed.\n${error.message}';
  //
  //         case AuthorizationErrorCode.invalidResponse:
  //           throw 'Something went wrong.\n${error.message}';
  //
  //         case AuthorizationErrorCode.notHandled:
  //           throw 'Something went wrong.\n${error.message}';
  //
  //         case AuthorizationErrorCode.unknown:
  //           throw 'Unknown error';
  //       }
  //     } else if (error is UnknownSignInWithAppleException) {
  //       Log.e(
  //         TAG,
  //         '_triggerAppleAuthentication',
  //         exception: error,
  //         stackTrace: StackTrace.fromString(error.stacktrace!),
  //       );
  //       throw 'Something went wrong.';
  //     }
  //
  //     Log.e(TAG, '_triggerAppleAuthentication', exception: error);
  //     throw error;
  //   });
  // }

  // Future<dynamic> signInWithGoogle() async {
  //   return await _triggerGoogleAuthentication().then((value) async {
  //     return await login(
  //       value['credential'],
  //       displayName: value['displayName'],
  //       email: value['email'],
  //       photoUrl: value['photoUrl'],
  //     );
  //   }, onError: (e) {
  //     Log.e(TAG, 'signInWithGoogle', exception: e);
  //     return Future.error(e);
  //   });
  // }
  //
  // Future<dynamic> signInWithFacebook() async {
  //   return await _triggerFacebookAuthentication().then((value) async {
  //     return await login(
  //       value['credential'],
  //       displayName: value['displayName'],
  //       email: value['email'],
  //       photoUrl: value['photoUrl'],
  //     );
  //   }, onError: (e) {
  //     Log.e(TAG, 'signInWithFacebook', exception: e);
  //     return Future.error(e);
  //   });
  // }
  //
  // Future<dynamic> signInWithApple() async {
  //   return await _triggerAppleAuthentication().then((value) async {
  //     return await login(
  //       value['credential'],
  //       displayName: value['displayName'],
  //       email: value['email'],
  //       photoUrl: value['photoUrl'],
  //     );
  //   }, onError: (e) {
  //     Log.e(TAG, 'signInWithApple', exception: e);
  //     return Future.error(e);
  //   });
  // }

  Future<Map<String, dynamic>> signInWithCredential(
      AuthCredential credential) async {
    Log.d(TAG, 'signInWithCredential: ${credential.toString()}');
    try {
      final userCredential = await _auth.signInWithCredential(credential);

      final user = await _saveUser(
          userCredential,
          AuthProviderType.values
              .singleWhere((element) => element.id == credential.providerId));
      //TODO handle user response
      return {
        'cred': userCredential,
        'user': user,
      };
    } on FirebaseAuthException catch (e) {
      Log.e(TAG, 'signInWithCredential', exception: e.toString());
      switch (e.code) {
        case 'session-expired':
          if (credential.providerId == PhoneAuthProvider.PROVIDER_ID)
            return Future.error('${e.message}');
          else
            return Future.error(
                'We have encountered an error. Please try again.');

        // case 'account-exists-with-different-credential':
        //   return _handleAccountExistsWithDifferentCredentials(e);

        default:
          return Future.error(e.message!);
      }
    } catch (e) {
      Log.e(TAG, '$e', references: ['signInWithCredential']);
      return Future.error('$e');
    }
  }

  Future<UserCredential> _handleAccountExistsWithDifferentCredentials(
      FirebaseAuthException e) async {
    Log.d(TAG, '_handleAccountExistsWithDifferentCredentials');
    // The account already exists with a different credential
    String email = e.email!;
    AuthCredential? pendingCredential = e.credential;

    // Fetch a list of what sign-in methods exist for the conflicting user
    List<String> userSignInMethods =
        await _auth.fetchSignInMethodsForEmail(email);
    Log.d(TAG, 'userSignInMethods : $userSignInMethods');

    //region email-password
    // Does not exists at the moment
    // // If the user has several sign-in methods,
    // // the first method in the list will be the "recommended" method to use.
    // if (userSignInMethods.first == 'password') {
    //   // Prompt the user to enter their password
    //   String password = '...';
    //
    //   // Sign the user in to their account with the password
    //   UserCredential userCredential = await auth.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //
    //   // Link the pending credential with the existing account
    //   await userCredential.user.linkWithCredential(pendingCredential);
    //
    //   // Success! Go back to your application flow
    //   return goToApplication();
    // }
    //endregion email-password

    //region facebook
    // Since other providers are now external, you must now sign the user in with another
    // auth provider, such as Facebook.
    if (userSignInMethods.first == 'facebook.com') {
      // return await _triggerFacebookAuthentication().then((value) async {
      //   // Sign the user in with the credential
      //   return await _signInWithCredential(value['credential']).then(
      //       (value) async => await _linkCredentials(
      //           value['credential'], pendingCredential!));
      // }, onError: (e) => Future.error(e));
    }
    //endregion facebook

    //region google
    // Since other providers are now external, you must now sign the user in with another
    // auth provider, such as Facebook.
    if (userSignInMethods.first == 'google.com') {
      // return await _triggerGoogleAuthentication().then((value) async {
      //   // Sign the user in with the credential
      //   return await _signInWithCredential(value['credential']).then(
      //       (value) async => await _linkCredentials(
      //           value['credential'], pendingCredential!));
      // }, onError: (e) => Future.error(e));
    }
    //endregion google

    //region apple
    // Since other providers are now external, you must now sign the user in with another
    // auth provider, such as Facebook.
    if (userSignInMethods.first == 'apple.com') {
      // return await _triggerAppleAuthentication().then((value) async {
      //   // Sign the user in with the credential
      //   return await _signInWithCredential(value['credential']).then(
      //       (value) async => await _linkCredentials(
      //           value['credential'], pendingCredential!));
      // }, onError: (e) => Future.error(e));
    }
    //endregion apple

    // unknown provider
    return Future.error(
        e.message ?? 'Unable to login. Please try other method.');
  }

  Future<AppUser> _saveUser(
      UserCredential credential, AuthProviderType authProviderType) async {
    Log.d(TAG, 'saveUser');

    var user = await getUser() ?? AppUser();

    final provider = AuthProvider();
    provider.isPrimary = false;
    provider.uid = credential.user!.uid;
    provider.provider = authProviderType.id;
    provider.identifier = authProviderType == AuthProviderType.Phone
        ? credential.user!.phoneNumber!
        : credential.user!.email!;

    if (user.providers == null) {
      provider.isPrimary = true;
      user.providers = []..add(provider);
    } else if (user.providers?.where((element) =>
            element.provider == provider.provider &&
            element.uid == provider.uid) ==
        null) {
      user.providers?.add(provider);
    }

    if (await setUser(user)) {
      return user;
    } else {
      return Future.error(ErrorMessages.SOMETHING_WENT_WRONG);
    }
  }

  //region api

  Future<Map<String, dynamic>> login(String mobile) async {
    // _analyticsService.logLogin(authProviderType.id);
    // Log.d(TAG, 'login: ${user.toString()}');
    return await _api.login(mobileNo: mobile).then((res) async {
      if (res.status) {
        // _analyticsService.setUserProperties(userId: user.firebaseUser!.uid);
        // _analyticsService.logLogin(authProviderType.id);
        // _databaseService.logLogin(authProviderType, user.firebaseUser!.uid!);

        Log.d(TAG, 'login : token : ${res.data?.token}');

        var _user = AppUser();

        _user.token = res.data?.token;
        // _user.id = res.data?.customer!.id.toString();
        // _user.profile = res.data?.customer;
        await _appState.setUser(_user);
        // await _appState.setAuthState(AuthState.SignedIn);
        return {'result': true};
      } else {
        if (res.code == 1011)
          return Future.error({
            'code': 'register',
            'error':
                'Sorry, your account is not registered with us. Please continue to get register.',
          });
        else
          // return Future.error(Utils.getError(res.error));
          return Future.error(
              res.message ?? ErrorMessages.SOMETHING_WENT_WRONG);
      }
    }, onError: (error) => Future.error(error));
  }

  Future<Map<String, dynamic>> verifyLogin(String mobile, String otp) async {
    // _analyticsService.logLogin(authProviderType.id);
    // Log.d(TAG, 'login: ${user.toString()}');
    return await _api.verifyLogin(mobileNo: mobile, otp: otp).then((res) async {
      if (res.status) {
        // _analyticsService.setUserProperties(userId: user.firebaseUser!.uid);
        // _analyticsService.logLogin(authProviderType.id);
        // _databaseService.logLogin(authProviderType, user.firebaseUser!.uid!);

        Log.d(TAG, 'login : token : ${res.data?.token}');

        var _user = AppUser();

        _user.token = res.data?.token;
        _user.id = res.data?.customer!.id.toString();
        _user.profile = res.data?.customer;
        await _appState.setUser(_user);
        await _appState.setAuthState(AuthState.SignedIn);
        return {'result': true};
      } else {
        if (res.code == 1011)
          return Future.error({
            'code': 'register',
            'error':
                'Sorry, your account is not registered with us. Please continue to get register.',
          });
        else
          // return Future.error(Utils.getError(res.error));
          return Future.error(
              res.message ?? ErrorMessages.SOMETHING_WENT_WRONG);
      }
    }, onError: (error) => Future.error(error));
  }

  Future<bool> register(
      {required int isParent,
      required String name,
      String? email,
      String? mobile}) async {
    var user = await getUser();

    if (user == null) {
      Log.e(TAG, 'user is null', references: ['register', 'getUser']);
      return Future.error(ErrorMessages.SOMETHING_WENT_WRONG);
    }

    return await _api
        .register(
            name: name,
            isParent: isParent,
            mobileNo: mobile,
            email: email)
        .then((res) async {
      if (res.status) {
        // _analyticsService.setUserProperties(userId: user.firebaseUser!.uid);
        // _analyticsService.logSignUp(user.firebaseUser!.uid!);

        user.profile = res.data?.customer;
        user.token = res.data?.token;

        await setUser(user);
        return await _setAuthState(AuthState.SignedIn);
      } else {
        // return Future.error(Utils.getError(res.error));
        return Future.error(res.message ?? ErrorMessages.SOMETHING_WENT_WRONG);
      }
    });
  }

  //endregion

// Future<bool> _updateUserInfo(
//     String currentProvider, String email, String phone) async {
//   Log.d(TAG, '_updateUserInfo: provider => $currentProvider');
//   Log.d(TAG, '_updateUserInfo: email => $email');
//   Log.d(TAG, '_updateUserInfo: phone => $phone');
//
//   try {
//     if (currentProvider == PhoneAuthProvider.PROVIDER_ID) {
//       if (email != null) {
//         await _auth.currentUser!.updateEmail(email);
//         return true;
//       }
//     } else if (currentProvider != PhoneAuthProvider.PROVIDER_ID &&
//         phone != null &&
//         (_auth.currentUser!.phoneNumber == null ||
//             _auth.currentUser?.phoneNumber != phone)) {
//       //region phone
//       return await _navigationService
//           .navigateTo(Routes.otpView,
//               arguments: OtpViewArguments(mobileNumber: phone))!
//           .then((phoneAuthCred) async {
//         if (phoneAuthCred is PhoneAuthCredential) {
//           try {
//             await _auth.currentUser!.updatePhoneNumber(phoneAuthCred);
//             return true;
//           } on FirebaseAuthException catch (e) {
//             Log.e(TAG, '_updateUserInfo => updatePhoneNumber', exception: e);
//             switch (e.code) {
//               case 'credential-already-in-use':
//                 Log.d(TAG, 'apps => ${Firebase.apps.length}');
//                 var previousUser = _auth.currentUser;
//
//                 var app = Firebase.apps.singleWhereOrNull(
//                     (element) => element.name == 'temporaryApp2');
//
//                 final firebaseAppTemp = app ??
//                     await Firebase.initializeApp(
//                         name: 'temporaryApp2',
//                         options: Firebase.apps[0].options);
//                 final FirebaseAuth firebaseAuthTemp =
//                     FirebaseAuth.instanceFor(app: firebaseAppTemp);
//
//                 try {
//                   return await firebaseAuthTemp
//                       .signInWithCredential(e.credential!)
//                       .then((value) async {
//                     var i = value.user!.providerData
//                         .where((element) => element.email != email)
//                         .toList()
//                         .length;
//
//                     if (i > 0) {
//                       Log.d(TAG,
//                           'account-exists-with-different-provider-value: ${value.user!.phoneNumber} has different email than ${email}');
//                       return Future.error(
//                           'Sorry, this phone number (${value.user!.phoneNumber}) already in use by another account.');
//                     } else {
//                       await value.user!.delete();
//                       return await previousUser!
//                           .updatePhoneNumber(phoneAuthCred)
//                           .then((value) => true, onError: (e) {
//                         Log.e(TAG,
//                             '_updateUserInfo => signInWithCredential => previousUser.updatePhoneNumber',
//                             exception: e.toString());
//                         return Future.error('$e');
//                       });
//                     }
//                   }, onError: (e) {
//                     Log.e(TAG, '_updateUserInfo => signInWithCredential',
//                         exception: e.toString());
//                     return Future.error('$e');
//                   });
//                 } on FirebaseAuthException catch (_e) {
//                   Log.e(TAG, '_updateUserInfo => updatePhoneNumber',
//                       exception: _e);
//                   return Future.error('$_e');
//                 } catch (e) {
//                   Log.e(TAG, 'updateUserInfo', exception: e);
//                   return Future.error('$e');
//                 } finally {
//                   await firebaseAppTemp.delete();
//                 }
//               default:
//                 return Future.error(e.message!);
//             }
//           }
//         } else {
//           return Future.error('Phone number not verified.');
//         }
//       });
//       //endregion
//     }
//     return true;
//   } on FirebaseAuthException catch (e) {
//     Log.e(TAG, '_updateUserInfo', exception: e);
//     switch (e.code) {
//       case 'email-already-in-use':
//         var previousUser = _auth.currentUser;
//
//         Log.d(TAG, 'apps => ${Firebase.apps.length}');
//
//         var app = Firebase.apps
//             .singleWhereOrNull((element) => element.name == 'temporaryApp2');
//
//         final firebaseAppTemp = app ??
//             await Firebase.initializeApp(
//                 name: 'temporaryApp2', options: Firebase.apps[0].options);
//         final FirebaseAuth firebaseAuthTemp =
//             FirebaseAuth.instanceFor(app: firebaseAppTemp);
//
//         var methods =
//             await firebaseAuthTemp.fetchSignInMethodsForEmail(email);
//
//         Log.d(TAG, 'currentUser => ${_auth.currentUser?.phoneNumber}');
//
//         var dResult = await _dialogService.authProviderPicker(
//           message:
//               'This email ($email) already in use by another account.\n\nContinue to authenticate via,',
//           providerIds: methods,
//           dismissible: true,
//         );
//
//         if (dResult == null) {
//           Log.d(TAG, 'clearing at top firebaseAppTemp');
//           await firebaseAppTemp.delete();
//           return Future.error('Authentication failed. Unable to proceed.');
//         } else {
//           return await _triggerProvider(dResult).then((value) async {
//             try {
//               print('previousUser ${previousUser!.phoneNumber}');
//               print('currentUser => ${_auth.currentUser?.phoneNumber}');
//
//               return await firebaseAuthTemp
//                   .signInWithCredential(value['credential'])
//                   .then((value) async {
//                 print('currentUser => ${_auth.currentUser?.phoneNumber}');
//
//                 var i = value.user!.providerData
//                     .where((element) => element.phoneNumber != phone)
//                     .toList()
//                     .length;
//
//                 if (i > 0) {
//                   Log.d(TAG,
//                       'account-exists-with-different-provider-value: ${value.user!.email} has different phone number than ${phone}');
//                   return Future.error(
//                       'Sorry, this email (${value.user!.email}) already in use by another account.');
//                 } else {
//                   Log.d(TAG, 'deleting user => ${value.user!.uid}');
//                   await value.user!.delete();
//                   return await previousUser
//                       .updateEmail(email)
//                       .then((value) => true, onError: (e) {
//                     Log.e(TAG,
//                         '_updateUserInfo => signInWithCredential => previousUser.updatePhoneNumber',
//                         exception: e.toString());
//                     return Future.error('$e');
//                   });
//                 }
//               }, onError: (e) {
//                 Log.e(TAG, '_updateUserInfo => signInWithCredential',
//                     exception: e.toString());
//                 return Future.error('$e');
//               });
//             } on FirebaseAuthException catch (_e) {
//               Log.e(TAG, '_updateUserInfo => updatePhoneNumber',
//                   exception: _e);
//               return Future.error('$_e');
//             } catch (e) {
//               Log.e(TAG, 'updateUserInfo', exception: e);
//               return Future.error('$e');
//             } finally {
//               Log.d(TAG, 'clearing at bottom firebaseAppTemp');
//               await firebaseAppTemp.delete();
//             }
//           }, onError: (error) => Future.error(error));
//         }
//       case 'invalid-verification-code':
//         return await _dialogService.confirm(
//           'Invalid verification code.',
//           dismissible: false,
//           positiveButtonText: 'Retry',
//           negativeButtonText: 'Change Number',
//           positiveCallback: (val) async =>
//               _updateUserInfo(currentProvider, email, phone),
//           negativeCallBack: (val) => _navigationService.back(result: false),
//         );
//       case 'requires-recent-login':
//       default:
//         return Future.error(e.message!);
//     }
//   }
// }
//
// Future<Map<String, dynamic>> _triggerProvider(String providerId) async {
//   // if (providerId == FacebookAuthProvider.PROVIDER_ID) {
//   //   return await _triggerFacebookAuthentication();
//   // } else if (providerId == GoogleAuthProvider.PROVIDER_ID) {
//   //   return await _triggerGoogleAuthentication();
//   // } else if (providerId == 'apple.com') {
//   //   return await _triggerAppleAuthentication();
//   // } else {
//   return Future.error('Unknown provider ($providerId)');
//   // }
// }

  void dispose() {
    Log.d(TAG, 'dispose');
    // _otpController.close();
  }
}
