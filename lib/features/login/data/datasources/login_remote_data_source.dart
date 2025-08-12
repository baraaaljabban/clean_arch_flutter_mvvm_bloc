import '../models/user_model.dart';

class LoginRemoteDataSource {
  const LoginRemoteDataSource();

  Future<User> authenticate({required String username, required String password}) async {
    // Mock network latency
    await Future<void>.delayed(const Duration(milliseconds: 300));
    // In a real app, perform a network call here and map the response
    return User(id: 1, username: username, email: '$username@example.com');
  }
}
