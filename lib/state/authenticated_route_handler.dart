import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/pages.dart';
import '../generate_routes.dart';
import 'state.dart';

class AuthenticatedRouteHandler extends StatelessWidget {
  final String initialRoute;

  const AuthenticatedRouteHandler({Key? key, required this.initialRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthStateNotifier>(
      builder: (context, authNotifier, child) {
        return Navigator(
          onGenerateRoute: (settings) {
            print(
                'authNotifier.isAuthenticated: ${authNotifier.isAuthenticated}');
            print('settings.name: ${settings.name}');
            // Update this to use the authentication state
            if (!authNotifier.isAuthenticated &&
                isProtectedRoute(settings.name)) {
              print('protected route');
              return MaterialPageRoute(builder: (_) => const SplashPage());
            }
            // Continue using your existing route generation logic
            print('generateRoute');
            return generateRoute(settings, context);
          },
          initialRoute: initialRoute,
        );
      },
    );
  }
}
