import 'package:experimental/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app_bloc_observer.dart';
import 'env.dart';
import 'src/supauth/supauth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  // Turn off the # in the URLs on the web
  usePathUrlStrategy();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => SupabaseRepository(
            client: supabase,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SupabaseAuthCubit(
              supabaseRepository: context.read<SupabaseRepository>(),
            ),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gluten Free Grove',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SignIn(),
        SignUp.routeName: (_) => const SignUp(),
        SignIn.routeName: (_) => const SignIn(),
        ForgotPassword.routeName: (_) => const ForgotPassword(),
      },
    );
  }
}
