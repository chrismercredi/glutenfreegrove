import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../../theme/theme.dart' show AuthThemeExtensions;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login-page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  final bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  bool _isPasswordVisible = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('login-page'),
      appBar: AppBar(
        actions: [
          OutlinedButton(
            onPressed: _isLoading
                ? null
                : () {
                    Navigator.of(context).pushNamed('/user-application-form');
                  },
            style: Theme.of(context).blackOutlinedButtonStyle(),
            child: const Text(
                'Apply for access'), // Apply the custom OutlinedButton style
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
                        validator: (value) =>
                            FormRegex.authValidateEmail(_emailController.text),
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
                        obscureText: !_isPasswordVisible, // Control visibility
                        style: Theme.of(context).emailTextStyle(),
                        cursorColor: Theme.of(context).emailCursorColor,
                        cursorWidth: Theme.of(context).emailCursorWidth,
                        decoration: Theme.of(context).passwordInputDecoration(
                          onTogglePasswordVisibility: _togglePasswordVisibility,
                          isPasswordVisible: _isPasswordVisible,
                        ), // Using the extension method
                      ),
                      const Gap(24),
                      SizedBox(
                        width: double
                            .infinity, // Make the button expand horizontally
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    // Perform login logic if form is valid
                                  }
                                },
                          style: Theme.of(context).blackSquareButtonStyle(),
                          child: Text(_isLoading
                              ? 'Loading'
                              : 'Login'), // Apply the custom button style
                        ),
                      ),
                      const Gap(8),
                      SizedBox(
                        width: double
                            .infinity, // Make the button expand horizontally
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/forgot-password-page');
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
    );
  }
}
