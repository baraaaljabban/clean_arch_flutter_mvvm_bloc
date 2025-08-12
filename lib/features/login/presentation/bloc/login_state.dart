import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});

  @override
  List<Object?> get props => <Object?>[message];
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}
