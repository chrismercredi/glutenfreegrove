import 'package:experimental/utils/utils.dart';

import '../user.dart';

class ProfileRepository {
  // Constructor
  ProfileRepository();

  // Fetch a profile by ID
  Future<ProfileModel> getProfile(String id) async {
    final data = await supabase
        .from('profiles')
        .select<Map<String, dynamic>>()
        .eq('id', id)
        .single();

    return ProfileModel.fromJson(data);
  }

  // Update a profile
  Future<bool> updateProfile(ProfileModel profile) async {
    bool isSuccess = await supabase
        .from('profiles')
        .update(profile.toJson())
        .eq('id', profile.id)
        .then((value) => true)
        .catchError((error) => false);
    return isSuccess;
  }

  // Create a new profile
  Future<ProfileModel> createProfile(ProfileModel profile) async {
    // TODO: Implement the logic to create a new profile in the data source
    // For now, returning the created profile
    return profile;
  }

  // Delete a profile
  Future<void> deleteProfile(String id) async {
    // TODO: Implement the logic to delete a profile from the data source
  }
}
