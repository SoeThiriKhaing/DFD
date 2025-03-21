class UserModel {
  final int id;
  final String name;
  final String email;
  final String? role;
  final String? accessToken;
  final String? phone;
  final String? gender;
  final String? age;
  final String? message;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.role,
    this.accessToken,
    this.phone, 
    this.gender, 
    this.age, 
    this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['user_role']?['name'] ?? 'user',
      accessToken: json['access_token'] ?? '',
      phone: json['phone_no'],
      gender: json['gender'],
      age: json['age'],
      message: json['message'],
    );
  }
}
