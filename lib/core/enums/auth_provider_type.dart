import 'package:easyenglish/core/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthProviderType { Phone, Google, Facebook, Apple }

extension AuthProviderTypeExtension on AuthProviderType {
  String get id {
    switch (this) {
      case AuthProviderType.Phone:
        return PhoneAuthProvider.PROVIDER_ID;
      case AuthProviderType.Google:
        return GoogleAuthProvider.PROVIDER_ID;
      case AuthProviderType.Facebook:
        return FacebookAuthProvider.PROVIDER_ID;
      case AuthProviderType.Apple:
        return 'apple.com';
    }
  }

  String get name {
    switch (this) {
      case AuthProviderType.Phone:
        return 'Mobile number';
      case AuthProviderType.Google:
      case AuthProviderType.Facebook:
      case AuthProviderType.Apple:
        return 'Email address';
    }
  }

  String get fieldIdentifier {
    switch (this) {
      case AuthProviderType.Phone:
        return DatabaseService.fieldMobile;
      case AuthProviderType.Google:
        return DatabaseService.fieldGoogle;
      case AuthProviderType.Facebook:
        return DatabaseService.fieldFacebook;
      case AuthProviderType.Apple:
        return DatabaseService.fieldApple;
    }
  }

  String get fieldUid {
    switch (this) {
      case AuthProviderType.Phone:
        return DatabaseService.fieldMobileUid;
      case AuthProviderType.Google:
        return DatabaseService.fieldGoogleUid;
      case AuthProviderType.Facebook:
        return DatabaseService.fieldFacebookUid;
      case AuthProviderType.Apple:
        return DatabaseService.fieldAppleUid;
    }
  }

  String get fieldLastLoggedAt {
    switch (this) {
      case AuthProviderType.Phone:
        return DatabaseService.fieldLastMobileLoggedAt;
      case AuthProviderType.Google:
        return DatabaseService.fieldLastGoogleLoggedAt;
      case AuthProviderType.Facebook:
        return DatabaseService.fieldLastFacebookLoggedAt;
      case AuthProviderType.Apple:
        return DatabaseService.fieldLastAppleLoggedAt;
    }
  }
}
