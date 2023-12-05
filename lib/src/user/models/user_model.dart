import '../../../models/roles.dart';

class UserModel {
  final int id;
  final String username;
  final String email;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final RoleModel role;
  final bool isPremium;
  final String avatarUrl; // URL to the user's avatar image

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    this.updatedAt,
    required this.role,
    this.isPremium = false,
    this.avatarUrl = '', // Default or placeholder avatar
  });

  // Add copyWith method
  UserModel copyWith({
    int? id,
    String? username,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    RoleModel? role,
    bool? isPremium,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      role: role ?? this.role,
      isPremium: isPremium ?? this.isPremium,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  // Add fromJson method
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      role: RoleModel.fromJson(json['role']),
      isPremium: json['isPremium'],
      avatarUrl: json['avatarUrl'],
    );
  }

  // Add toJson method
  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': updatedAt?.toIso8601String(),
      'role': role.toJson(), // Assuming RoleModel has a toJson method
      'isPremium': isPremium,
      'avatarUrl': avatarUrl,
    };
  }
}
