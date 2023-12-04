import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const String routeName = '/splash-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/items-page');
            },
            icon: const Tooltip(
              message: 'Items',
              child: Icon(
                Icons.store,
                semanticLabel: 'Items IconButton',
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/user-profile-private');
            },
            icon: const Tooltip(
              message: 'Login',
              child: Icon(
                Icons.person,
                semanticLabel: 'Login IconButton',
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login-page');
            },
            icon: const Tooltip(
              message: 'Login',
              child: Icon(
                Icons.login_outlined,
                semanticLabel: 'Login IconButton',
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'MM',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.staatliches().fontFamily,
          ),
        ),
      ),
    );
  }
}
