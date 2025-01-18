class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String accessToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['user_role']?['name'] ?? 'user',
      accessToken: json['access_token'] ?? '',
    );
  }
}
