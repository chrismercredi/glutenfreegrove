import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../supauth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static const routeName = '/forgot_password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      context.read<SupabaseAuthCubit>().resetPasswordForEmail(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupabaseAuthCubit, SupabaseAuthState>(
      listenWhen: (previous, current) {
        return false;
      },
      listener: (context, state) {
        if (state is SupabaseAuthPasswordReset) {
          Navigator.of(context).pop();
        }
      },
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthListTile(
                    title: 'Forgot password',
                    subtitle:
                        'Enter your email and we will send you a link to reset your password',
                    buttonText: 'Sign in',
                    onButtonPressed: () {
                      context.read<SupabaseAuthCubit>().showSignIn();
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.surface,
                        labelText: 'Email',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                      validator: ValidationUtil.validateEmail,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _sendResetEmail,
                        child: const Text('Send reset instructions'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
