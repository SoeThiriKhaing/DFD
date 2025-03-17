import 'package:flutter_secure_storage/flutter_secure_storage.dart';

 const storage = FlutterSecureStorage();

Future<void> saveToken(String token) async {
  await storage.write(key: 'authToken', value: token);
}

Future<String?> getToken() async {
  return await storage.read(key: 'authToken');
}

Future<void> saveUserId(int userId) async {
  await storage.write(key: 'userId', value: userId.toString());
}

Future<String?> getUserId() async {
  return await storage.read(key: 'userId');
}

Future<void> saveUserName(String userName) async {
  await storage.write(key: 'userName', value: userName);
}

Future<String?> getUserName() async {
  return await storage.read(key: 'userName');
}

Future<void> saveUserRole(String userRole) async {
  await storage.write(key: 'userRole', value: userRole);
}

Future<String?> getUserRole() async {
  return await storage.read(key: 'userRole');
}
