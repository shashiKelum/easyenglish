import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  FirebaseAnalytics get instance => _analytics;

  // User properties tells us what the user is
  Future setUserProperties({required String? userId, String? city}) async {
    await _analytics.setUserId(id: userId);
    if (city != null) {
      await _analytics.setUserProperty(name: 'user_city', value: city);
    }
    // property to indicate if it's a pro paying member
    // property that might tell us it's a regular poster, etc
  }

  Future logLogin(String provider) async {
    await _analytics.logLogin(loginMethod: provider);
  }

  Future logSignUp(String provider) async {
    await _analytics.logSignUp(signUpMethod: provider);
  }

  Future logPostCreated({bool? hasImage}) async {
    await _analytics.logEvent(
      name: 'create_post',
      parameters: {'has_image': hasImage},
    );
  }
}
