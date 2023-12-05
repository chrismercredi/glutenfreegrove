import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../supauth.dart';

class AuthBottomSheet extends StatelessWidget {
  const AuthBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: BlocBuilder<SupabaseAuthCubit, SupabaseAuthState>(
        builder: (context, state) {
          if (state is SupabaseAuthSignIn) {
            return const SignIn();
          } else if (state is SupabaseAuthSignUp) {
            return const SignUp();
          } else if (state is SupabaseAuthForgotPassword) {
            return const ForgotPassword();
          } else {
            return const SignIn();
          }
        },
      ),
    );
  }
}
