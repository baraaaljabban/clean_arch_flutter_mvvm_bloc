import '../../../../core/dependency_registrar/dependencies.dart';
import '../models/user_model.dart';
import '../datasources/login_local_data_source.dart';
import '../datasources/login_remote_data_source.dart';

class LoginRepository {
  final LoginRemoteDataSource remoteDataSource = sl();
  final LoginLocalDataSource localDataSource = sl();

  Future<void> login({required String username, required String password}) async {
    final User user = await remoteDataSource.authenticate(username: username, password: password);
    await localDataSource.persistLoggedInUser(user);
  }
}
