import 'package:dailyfairdeal/models/user/user_model.dart';

import '../../repositories/auth/auth_repository.dart';

class AuthService {
  final AuthRepository authRepository;

  AuthService({required this.authRepository});

  Future<UserModel> login(String email, String password) async {
    return await authRepository.login(email, password);
  }

  Future<UserModel> register(String name, String email, String password) async {
    return await authRepository.register(name, email, password);
  }

  Future<String> logout() async {
    return await authRepository.logout();
  }

  Future<List<UserModel>> getUserInfoById(int userId) async{
    return await authRepository.getUserInfoById(userId);
  }
}
