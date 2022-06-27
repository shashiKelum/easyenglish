import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/services/analytics_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => AnalyticsService());
  GetIt.I.registerLazySingleton(() => NavigationService());
}
