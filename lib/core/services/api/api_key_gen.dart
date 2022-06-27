import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../core/config/application.dart';

class ApiKeyGen {
  static KeyGen generate() {
    String _timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String _key;

    var key = utf8.encode(Application.encKey);
    var bytes = utf8.encode(_timeStamp);

    var hmac = new Hmac(sha256, key); // HMAC-SHA256
    var digest = hmac.convert(bytes);

    // print("HMAC digest as bytes: ${digest.bytes}");
    // print("HMAC digest as hex string: $digest");

    _key = digest.toString();

    return KeyGen(_timeStamp, _key);
  }
}

class KeyGen {
  final String timeStamp;
  final String key;

  KeyGen(this.timeStamp, this.key);
}
