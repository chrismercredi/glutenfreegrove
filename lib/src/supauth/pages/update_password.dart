import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../utils/utils.dart';
import '../supauth.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({
    super.key,
  });

  static const routeName = '/update-password';

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String nonce = '';
  bool _isLoading = false;

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final password = _passwordController.text.trim();
      nonce = supabase.auth.currentSession!.accessToken;
      print('nonce: $nonce');
      print('password: $password');
      context.read<SupabaseAuthCubit>().updateUserPassword(password, nonce);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupabaseAuthCubit, SupabaseAuthState>(
      listener: (context, state) {
        if (state is SupabaseAuthPasswordUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password successfully updated')),
          );
          setState(() => _isLoading = false);
        } else if (state is SupabaseAuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          setState(() => _isLoading = false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Password'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) =>
                          FormRegex.authValidatePassword(value),
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                    ),
                    const Gap(8),
                    TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                      decoration: const InputDecoration(
                        labelText: 'Confirm New Password',
                      ),
                    ),
                    const Gap(16),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _updatePassword,
                      child:
                          Text(_isLoading ? 'Updating...' : 'Update Password'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
