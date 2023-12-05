import 'package:experimental/state/authenticated_route_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import 'env.dart';
import 'state/state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthStateNotifier()),
        ChangeNotifierProvider(create: (context) => UserProfileNotifier()),
        ChangeNotifierProvider(create: (context) => ItemNotifier()),
        ChangeNotifierProvider(create: (context) => CartNotifier()),
        // Add other providers here
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      home: const AuthenticatedRouteHandler(initialRoute: '/'),
    );
  }
}

// Fake user: email: test@gmail.com, password: test1234?C12
// christophermercredi@gmail.com, test1234?C12