import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../utils/utils.dart';
import '../../../theme/theme.dart' show AuthThemeExtensions;
import '../../../widgets/widgets.dart';
import '../supauth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      context.read<SupabaseAuthCubit>().signUp(email, password);
    }
  }

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
        key: const Key('login-page'),
        appBar: AppBar(
          actions: [
            OutlinedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.of(context).pushNamed('/sign-in');
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
                const Text('Sign Up'),
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
                        const Gap(8),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) => FormRegex.authValidatePassword(
                              _passwordController.text),
                          obscureText:
                              !_isPasswordVisible, // Control visibility
                          style: Theme.of(context).emailTextStyle(),
                          cursorColor: Theme.of(context).emailCursorColor,
                          cursorWidth: Theme.of(context).emailCursorWidth,
                          decoration: Theme.of(context).passwordInputDecoration(
                            onTogglePasswordVisibility:
                                _togglePasswordVisibility,
                            isPasswordVisible: _isPasswordVisible,
                          ), // Using the extension method
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          obscureText:
                              !_isPasswordVisible, // Control visibility
                          style: Theme.of(context).emailTextStyle(),
                          cursorColor: Theme.of(context).emailCursorColor,
                          cursorWidth: Theme.of(context).emailCursorWidth,
                          decoration: Theme.of(context).passwordInputDecoration(
                            onTogglePasswordVisibility:
                                _togglePasswordVisibility,
                            isPasswordVisible: _isPasswordVisible,
                          ), // Using the extension method
                        ),
                        const Gap(16),
                        SizedBox(
                          width: double
                              .infinity, // Make the button expand horizontally
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : () => _signUp(),
                            style: Theme.of(context).blackSquareButtonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(_isLoading ? 'Loading' : 'Sign up'),
                            ), // Apply the custom button style
                          ),
                        ),
                        const Gap(8),
                        SizedBox(
                          width: double
                              .infinity, // Make the button expand horizontally
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/forgot-password');
                            },
                            style: Theme.of(context).blackTextButtonStyle(),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('Forgot password?'),
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
