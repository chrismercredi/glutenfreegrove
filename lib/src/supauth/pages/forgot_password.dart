import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../widgets/widgets.dart';
import '../supauth.dart';
import '../../../utils/utils.dart';
import '../../../theme/theme.dart' show AuthThemeExtensions;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static const routeName = '/forgot-password';

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

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupabaseAuthCubit, SupabaseAuthState>(
      listenWhen: (previous, current) {
        return current is SupabaseAuthAuthenticated;
      },
      listener: (context, state) {
        if (state is SupabaseAuthAuthenticated) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        key: const Key('forgot-password-page'),
        appBar: AppBar(
          actions: [
            OutlinedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.of(context).pushNamed('/sign-up');
                    },
              style: Theme.of(context).blackOutlinedButtonStyle(),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Sign in'),
              ), // Apply the custom OutlinedButton style
            ),
            const Gap(8),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MM(),
                const Text('Forgot password?'),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: formColumnPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) => FormRegex.authValidateEmail(
                              _emailController.text),
                          style: Theme.of(context).emailTextStyle(),
                          cursorColor: Theme.of(context).emailCursorColor,
                          cursorWidth: Theme.of(context).emailCursorWidth,
                          decoration: Theme.of(context)
                              .emailInputDecoration(), // Using the extension method
                        ),
                        const Gap(16),
                        SizedBox(
                          width: double
                              .infinity, // Make the button expand horizontally
                          child: ElevatedButton(
                            onPressed:
                                _isLoading ? null : () => _sendResetEmail,
                            style: Theme.of(context).blackSquareButtonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  _isLoading ? 'Loading' : 'Reset password'),
                            ), // Apply the custom button style
                          ),
                        ),
                        const Gap(8),
                        SizedBox(
                          width: double
                              .infinity, // Make the button expand horizontally
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/sign-in');
                            },
                            style: Theme.of(context).blackTextButtonStyle(),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('Cancel'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
