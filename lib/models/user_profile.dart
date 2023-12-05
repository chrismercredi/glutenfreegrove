class UserProfile {
  final bool _isPremium = false;
  final String _avatarUrl = '';
  final String _username = '';
  final String _fullName = '';
  final String _website = '';

  bool get isPremium => _isPremium;
  String get avatarUrl => _avatarUrl;

  UserProfile({
    bool? isPremium,
    String? avatarUrl,
    String? username,
    String? fullName,
    String? website,
  });

  UserProfile copyWith({
    bool? isPremium,
    String? avatarUrl,
    String? username,
    String? fullName,
    String? website,
  }) {
    return UserProfile(
      isPremium: isPremium ?? this.isPremium,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      username: username ?? _username,
      fullName: fullName ?? _fullName,
      website: website ?? _website,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      isPremium: json['isPremium'],
      avatarUrl: json['avatarUrl'],
      username: json['username'],
      fullName: json['fullName'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isPremium': _isPremium,
      'avatarUrl': _avatarUrl,
      'username': _username,
      'fullName': _fullName,
      'website': _website,
    };
  }
}
