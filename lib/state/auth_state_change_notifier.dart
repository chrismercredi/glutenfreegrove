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

  User get user => supabase.auth.currentUser!;

  Future<void> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception(error.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception(error.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<bool> signUpNewUser(String email, String password) async {
    try {
      var response =
          await supabase.auth.signUp(email: email, password: password);
      return response.user != null;
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception(error.toString());
    } finally {
      notifyListeners(); // Ensure UI is updated with the latest auth state
    }
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }
}
