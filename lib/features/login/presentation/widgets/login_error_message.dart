import 'package:flutter/material.dart';

class LoginErrorMessage extends StatelessWidget {
  final String message;
  const LoginErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(color: Colors.red),
      textAlign: TextAlign.start,
    );
  }
}
