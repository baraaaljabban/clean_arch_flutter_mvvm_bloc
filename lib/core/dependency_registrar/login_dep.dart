import 'package:shared_preferences/shared_preferences.dart';

import '../../features/login/data/datasources/login_local_data_source.dart';
import '../../features/login/data/datasources/login_remote_data_source.dart';
import '../../features/login/data/repositories/login_repository.dart';
import '../../features/login/presentation/usecases/login_use_case.dart';
import 'dependencies.dart';

void registerLoginDep() {
  sl.registerLazySingleton<LoginRemoteDataSource>(() => const LoginRemoteDataSource());
  sl.registerLazySingleton<LoginLocalDataSource>(() => LoginLocalDataSource(prefs: sl<SharedPreferences>()));

  sl.registerLazySingleton<LoginRepository>(() => LoginRepository());
  sl.registerFactory<LoginUseCase>(() => LoginUseCase(repository: sl<LoginRepository>()));
}
