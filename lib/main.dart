import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'env.dart';
import 'models/models.dart';
import 'pages/pages.dart';
import 'state/state.dart';
import 'utils/utils.dart';

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

  // Generate fake data for items
  final List<Item> fakeItems = List.generate(
    10,
    (index) => Item(
      id: index,
      name: 'Item $index',
      description: 'Description of item $index',
      price: 20.0 + index,
      category: 'Category ${index % 3}',
      createdAt: DateTime.now().subtract(Duration(days: index * 5)),
      images: [
        'https://picsum.photos/seed/$index/200/300',
        'https://picsum.photos/seed/${index + 1}/200/300',
        'https://picsum.photos/seed/${index + 2}/200/300',
      ],
    ),
  );

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
    case ItemsCatalog.routeName:
      return MaterialPageRoute(
        builder: (_) => ItemsCatalog(items: fakeItems),
      );
    case ItemsCatalogAlt.routeName:
      return MaterialPageRoute(
        builder: (_) => ItemsCatalogAlt(items: fakeItems),
      );

    /////////////////
    /// Cart      ///
    /////////////////
    case CartPage.routeName:
      return MaterialPageRoute(
        builder: (_) => CartPage(
          items: fakeItems,
        ),
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
