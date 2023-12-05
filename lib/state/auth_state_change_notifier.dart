import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/utils.dart';

class AuthStateNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;
  late final StreamSubscription<AuthState> _authStateSubscription;

  AuthStateNotifier() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      _isAuthenticated = session != null;
      notifyListeners();
    });
  }

  bool get isAuthenticated => _isAuthenticated;

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }
}

class AuthStateProvider extends InheritedWidget {
  final AuthStateNotifier notifier;

  const AuthStateProvider({
    Key? key,
    required this.notifier,
    required Widget child,
  }) : super(key: key, child: child);

  static AuthStateNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AuthStateProvider>()!
        .notifier;
  }

  @override
  bool updateShouldNotify(AuthStateProvider oldWidget) {
    return notifier != oldWidget.notifier;
  }
}
