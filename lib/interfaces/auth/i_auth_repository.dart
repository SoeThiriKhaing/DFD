import 'package:dailyfairdeal/models/user/user_model.dart';

abstract class IAuthRepository {
  //For Login
  Future<UserModel> login(String email, String password);
  //For Register
  Future<UserModel> register(String name, String email, String password);
  //For Logout
  Future<void> logout();
}
