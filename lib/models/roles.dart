class RoleModel {
  final int id;
  final String name;
  final List<String> permissions;
  final String icon; // Icon representing the role

  RoleModel({
    required this.id,
    required this.name,
    this.permissions = const [],
    this.icon = '', // Default or placeholder icon
  });

  // Add copyWith method
  RoleModel copyWith({
    int? id,
    String? name,
    List<String>? permissions,
    String? icon,
  }) {
    return RoleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      permissions: permissions ?? this.permissions,
      icon: icon ?? this.icon,
    );
  }

  // Add fromJson method
  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      name: json['name'],
      permissions: json['permissions'] != null
          ? List<String>.from(json['permissions'])
          : [],
      icon: json['icon'],
    );
  }

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions,
      'icon': icon,
    };
  }
}
