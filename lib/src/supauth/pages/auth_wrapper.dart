import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glutenfreegrove/src/user/user.dart';
import 'package:go_router/go_router.dart';

import '../supauth.dart';
import '../../../pages/splash_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  static const routeName = '/auth-wrapper';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupabaseAuthCubit, SupabaseAuthState>(
      listener: (context, state) {
        if (state is SupabaseAuthAuthenticated) {
          // Navigate to the authenticated user home page
          GoRouter.of(context).pushReplacementNamed(UserPage.routeName);
        } else if (state is SupabaseAuthUnauthenticated) {
          // Navigate to the sign-in page
          GoRouter.of(context).pushReplacementNamed(SignIn.routeName);
        }
        // Handle other states if necessary
      },
      builder: (context, state) {
        if (state is SupabaseAuthLoading) {
          return const CircularProgressIndicator();
        }
        // Return a placeholder/splash screen while determining the initial state
        return const SplashPage();
      },
    );
  }
}
