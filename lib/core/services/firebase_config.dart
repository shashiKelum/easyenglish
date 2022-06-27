import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseConfig {
  static const TAG = 'FirebaseConfig';
  RemoteConfig? _instance;

  var _defaults = {
    'next_win_multiplier': 2,
    'min_tryout_count': 10,
    'max_tryout_count': 100,
    'default_probability': 0.01,
    'force_win': false,
    'payment_online_dev': false,
    'payment_online_tst': false,
    'payment_online_prod': false,
    'payment_cash_dev': true,
    'payment_cash_tst': true,
    'payment_cash_prod': true,
  };

  FirebaseConfig() {
    init();
  }

  Future<void> init() async {
    _instance = await _getInstance();
    await _instance!.setDefaults(_defaults);
    await _instance!.fetch();
    await _instance!.fetchAndActivate();
  }

  Future<RemoteConfig?> _getInstance() async {
    if (_instance == null) return await RemoteConfig.instance;
    return _instance;
  }

// Future<GameEntity> getGameConfig() async {
//   await _instance.activateFetched();
//   var _config = await _instance.getAll();
//   Log.d(
//       TAG, '${_config.map((key, value) => MapEntry(key, value.asString()))}');
//   return GameEntity(
//     defaultProbability: _config['default_probability'].asDouble(),
//     forceWin: _config['force_win'].asBool(),
//     maxTryoutCount: _config['max_tryout_count'].asInt(),
//     minTryoutCount: _config['min_tryout_count'].asInt(),
//     nextWinMultiplier: _config['next_win_multiplier'].asDouble(),
//   );
// }
//
// Future<PaymentConfigEntity> getPaymentConfig() async {
//   await _instance.activateFetched();
//   var _config = await _instance.getAll();
//   Log.d(
//       TAG, '${_config.map((key, value) => MapEntry(key, value.asString()))}');
//   return PaymentConfigEntity(
//     paymentCashDev: _config['payment_cash_dev'].asBool(),
//     paymentCashProd: _config['payment_cash_prod'].asBool(),
//     paymentCashTst: _config['payment_cash_tst'].asBool(),
//     paymentOnlineDev: _config['payment_online_dev'].asBool(),
//     paymentOnlineProd: _config['payment_online_prod'].asBool(),
//     paymentOnlineTst: _config['payment_online_tst'].asBool(),
//   );
// }
}
