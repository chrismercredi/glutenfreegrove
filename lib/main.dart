import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final AuthStateNotifier authStateNotifier = AuthStateNotifier();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      home: const SplashPage(),
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }
}

Route<dynamic> _generateRoute(RouteSettings settings) {
  final session = supabase.auth.currentSession;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => const SplashPage(),
      );

    /////////////////
    /// Auth      ///
    /////////////////
    case UserApplicationForm.routeName:
      return MaterialPageRoute(
        builder: (_) => const UserApplicationForm(),
      );
    case LoginPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const LoginPage(),
      );
    case ForgotPasswordPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const ForgotPasswordPage(),
      );
    case LoginPageMagicLink.routeName:
      return MaterialPageRoute(
        builder: (_) => const LoginPageMagicLink(),
      );

    /////////////////
    /// User      ///
    /////////////////

    case UserProfilePrivate.routeName:
      return MaterialPageRoute(
        builder: (_) => const UserProfilePrivate(),
      );

    /////////////////
    /// Items     ///
    /////////////////
    case ItemPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const ItemPage(),
      );

    /////////////////
    /// Default   ///
    /////////////////
    default:
      return MaterialPageRoute(
        builder: (_) => const SplashPage(),
      );
  }
}
