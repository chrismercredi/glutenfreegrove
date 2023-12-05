class ProfileModel {
  final String id;
  final DateTime updatedAt;
  final String username;
  final String fullName;
  final String? avatarUrl;
  final String? website;

  ProfileModel({
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.fullName,
    this.avatarUrl,
    this.website,
  });

  ProfileModel copyWith({
    String? id,
    DateTime? updatedAt,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? website,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      website: website ?? this.website,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      updatedAt: DateTime.parse(json['updated_at']),
      username: json['username'],
      fullName: json['full_name'],
      avatarUrl: json['avatar_url'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'username': username,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'website': website,
    };
  }
}
