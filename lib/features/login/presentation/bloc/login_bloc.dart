import 'package:flutter_bloc/flutter_bloc.dart';

import '../usecases/login_use_case.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    // Validation
    if (event.username.trim().isEmpty || event.password.trim().isEmpty) {
      emit(const LoginError(message: 'Username and password are required'));
      return;
    }

    emit(const LoginLoading());
    try {
      await loginUseCase(LoginParams(username: event.username, password: event.password));
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
