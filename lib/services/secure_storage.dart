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

Future<void> saveDriverId(String driverId) async {
  await storage.write(key: 'driverId', value: driverId);
}

Future<String?> getDriverId() async {
  return await storage.read(key: 'driverId');
}

// Save notified travel accept IDs (to prevent duplicate notifications)
Future<void> saveNotifiedTravelIds(Set<int> travelIds) async {
  await storage.write(key: 'notifiedTravelIds', value: travelIds.join(','));
}

// Retrieve notified travel accept IDs
Future<Set<int>> getNotifiedTravelIds() async {
  String? storedIds = await storage.read(key: 'notifiedTravelIds');
  if (storedIds == null || storedIds.isEmpty) {
    return {};
  }
  return storedIds.split(',').map(int.parse).toSet();
}

//Clear all secure storage
Future<void> clearSecureStorage() async {
  await storage.deleteAll();
}
