import 'package:experimental/theme/auth_theme_extensions.dart';
import 'package:experimental/widgets/mm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../utils/utils.dart';
import '../supauth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  static const routeName = '/sign_in';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      context.read<SupabaseAuthCubit>().signIn(email, password);
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
                      Navigator.of(context).pushNamed('/sign-up-page');
                    },
              style: Theme.of(context).blackOutlinedButtonStyle(),
              child: const Text(
                  'Sign up'), // Apply the custom OutlinedButton style
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
                const Text('Login Page'),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: formColumnPadding,
                    child: Column(
                      children: [
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
                        const Gap(24),
                        SizedBox(
                          width: double
                              .infinity, // Make the button expand horizontally
                          child: ElevatedButton(
                            onPressed: _signIn,
                            style: Theme.of(context).blackSquareButtonStyle(),
                            child: const Text('Sign In'),
                            // Apply the custom button style
                          ),
                        ),
                        const Gap(8),
                        SizedBox(
                          width: double
                              .infinity, // Make the button expand horizontally
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<SupabaseAuthCubit>()
                                  .showForgotPassword();
                            },
                            style: Theme.of(context).blackTextButtonStyle(),
                            child: const Text('Forgot Password?'),
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
