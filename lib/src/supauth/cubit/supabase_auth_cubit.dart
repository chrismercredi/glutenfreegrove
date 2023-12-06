import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_repository.dart';

part 'supabase_auth_state.dart';

class SupabaseAuthCubit extends Cubit<SupabaseAuthState> {
  final SupabaseRepository supabaseRepository;
  StreamSubscription<AuthState>? _authSubscription;

  SupabaseAuthCubit({required this.supabaseRepository})
      : super(SupabaseAuthInitial()) {
    _init();
  }

  void _init() {
    final user = supabaseRepository.getCurrentUser();
    if (user != null) {
      emit(SupabaseAuthAuthenticated(user));
    } else {
      emit(SupabaseAuthUnauthenticated());
    }

    _authSubscription = supabaseRepository.onAuthStateChange.listen(
      (AuthState state) {
        final user = state.session?.user;
        if (user != null) {
          emit(SupabaseAuthAuthenticated(user));
        } else {
          emit(SupabaseAuthUnauthenticated());
        }
      },
      onError: (error) {
        emit(const SupabaseAuthError(
            'An error occurred while listening to authentication state changes'));
      },
    );
  }

  void showSignIn() {
    emit(SupabaseAuthSignIn());
  }

  void showSignUp() {
    emit(SupabaseAuthSignUp());
  }

  void showForgotPassword() {
    emit(SupabaseAuthForgotPassword());
  }

  Future<void> signUp(String email, String password) async {
    try {
      emit(SupabaseAuthLoading());
      final user =
          await supabaseRepository.signUp(email: email, password: password);
      if (user != null) {
        emit(SupabaseAuthAuthenticated(user));
      } else {
        emit(const SupabaseAuthError('Sign up failed'));
      }
    } catch (e) {
      emit(SupabaseAuthError(
          'An error occurred during sign up: ${e.toString()}'));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      emit(SupabaseAuthLoading());
      final user =
          await supabaseRepository.signIn(email: email, password: password);
      if (user != null) {
        emit(SupabaseAuthAuthenticated(user));
      } else {
        emit(const SupabaseAuthError('Sign in failed'));
      }
    } catch (e) {
      emit(SupabaseAuthError(
          'An error occurred during sign in: ${e.toString()}'));
    }
  }

  Future<void> signOut() async {
    try {
      await supabaseRepository.signOut();
      emit(SupabaseAuthUnauthenticated());
    } catch (e) {
      emit(SupabaseAuthError('Sign out failed: ${e.toString()}'));
    }
  }

  Future<void> deleteUser({required String uid}) async {
    try {
      await supabaseRepository.deleteUser(uid: uid);
      emit(SupabaseAuthDeletedUser());
    } catch (e) {
      emit(SupabaseAuthError('Delete user failed: ${e.toString()}'));
    }
  }

  Future<void> resetPasswordForEmail(String email) async {
    try {
      emit(SupabaseAuthLoading());
      print(email);
      await supabaseRepository.resetPasswordForEmail(email: email);
      emit(SupabaseAuthPasswordReset(
          'Password reset email sent to $email. Please check your inbox.'));
    } catch (e) {
      emit(SupabaseAuthError('Password reset failed: ${e.toString()}'));
    }
  }

  Future<void> updateUserPassword(String password, String? nonce) async {
    try {
      emit(SupabaseAuthLoading());
      await supabaseRepository.updateUserPassword(password, nonce);
      emit(SupabaseAuthPasswordUpdated());
    } catch (e) {
      emit(SupabaseAuthError('Password update failed: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
