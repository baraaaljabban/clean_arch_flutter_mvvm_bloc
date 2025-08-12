import 'package:flutter/material.dart';

class LoginSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  const LoginSubmitButton({super.key, required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Login'),
    );
  }
}
