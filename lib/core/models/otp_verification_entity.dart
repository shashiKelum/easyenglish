import 'package:firebase_auth/firebase_auth.dart';

import '../../core/enums/otp_verification_status.dart';

class OTPVerificationEntity {
  OTPVerificationStatus status;
  PhoneAuthCredential? credential;
  String? message;
  String? otpMessage;
  String? verificationId;
  int? resendToken;

  OTPVerificationEntity(
      {required this.status,
      this.credential,
      this.message,
      this.otpMessage,
      this.verificationId,
      this.resendToken});

  void update(
      {required OTPVerificationStatus status,
      PhoneAuthCredential? credential,
      String? verificationId,
      int? resendToken}) {
    this.status = status;
    if (credential != null) this.credential = credential;
    if (verificationId != null) this.verificationId = verificationId;
    if (resendToken != null) this.resendToken = resendToken;
  }
}
