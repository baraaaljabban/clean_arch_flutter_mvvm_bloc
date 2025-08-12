import '../../data/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<void> call(LoginParams params) {
    return repository.login(username: params.username, password: params.password);
  }
}

class LoginParams {
  final String username;
  final String password;
  const LoginParams({required this.username, required this.password});
}
