import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'pages/pages.dart';
import 'src/supauth/supauth.dart';
import 'src/user/pages/pages.dart';

final routerConfig = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        final authCubit = context.read<SupabaseAuthCubit>();
        if (authCubit.state is SupabaseAuthAuthenticated) {
          return const UserPage();
        } else {
          return const SignIn();
        }
      },
      routes: <GoRoute>[
        GoRoute(
          path: 'forgot-password',
          name: ForgotPassword.routeName,
          builder: (context, state) => const ForgotPassword(),
        ),
        GoRoute(
          path: 'sign-in',
          name: SignIn.routeName,
          builder: (context, state) => const SignIn(),
        ),
        GoRoute(
          path: 'sign-up',
          name: SignUp.routeName,
          builder: (context, state) => const SignUp(),
        ),
        GoRoute(
          path: 'update-password',
          name: UpdatePassword.routeName,
          builder: (context, state) => const UpdatePassword(),
        ),
        GoRoute(
          path: 'user',
          name: UserPage.routeName,
          builder: (context, state) => const UserPage(),
        ),
        GoRoute(
          path: 'user-profile',
          name: UserProfile.routeName,
          builder: (context, state) => const UserProfile(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const ErrorPage(),
);
