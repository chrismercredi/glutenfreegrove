import 'package:flutter/material.dart';

import '../models/models.dart';
import '../utils/utils.dart';

class UserProfileNotifier extends ChangeNotifier {
  /// Called once a user id is received within `onAuthenticated()`
  Future<UserModel> getProfile() async {
    final user = supabase.auth.currentUser;
    try {
      final userId = user!.id;
      final data = await supabase
          .from('profiles')
          .select<Map<String, dynamic>>()
          .eq('id', userId)
          .single();
      return UserModel.fromJson(data);
    } finally {
      notifyListeners();
    }
  }

  /// Called when user taps `Update` button
  Future<void> updateProfile(UserModel userModel) async {
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userModel.username,
      'email': userModel.email,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'role': userModel.role,
      'is_premium': userModel.isPremium,
      'avatar_url': userModel.avatarUrl,
    };
    try {
      await supabase.from('profiles').upsert(updates);
    } finally {
      notifyListeners();
    }
  }
}
