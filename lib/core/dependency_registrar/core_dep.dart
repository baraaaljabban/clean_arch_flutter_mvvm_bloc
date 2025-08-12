import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../network/connection_checker.dart';
import 'dependencies.dart';

Future<void> registerCoreDep() async {
  // Core services
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionChecker());
  sl.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
}
