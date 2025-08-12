import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_router.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widgets/login_text_field.dart';
import '../widgets/login_error_message.dart';
import '../widgets/login_submit_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) {
            if (state is LoginSuccess) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.questions);
            }
          },
          builder: (BuildContext context, LoginState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LoginTextField(controller: _usernameController, labelText: 'Username'),
                const SizedBox(height: 12),
                LoginTextField(controller: _passwordController, labelText: 'Password', obscureText: true),
                const SizedBox(height: 24),
                if (state is LoginError) ...<Widget>[
                  LoginErrorMessage(message: state.message),
                  const SizedBox(height: 12),
                ],
                LoginSubmitButton(
                  isLoading: state is LoginLoading,
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginSubmitted(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        ));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
