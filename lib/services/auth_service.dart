import 'package:dailyfairdeal/models/user_model.dart';

import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository authRepository;

  AuthService({required this.authRepository});

  Future<UserModel> login(String email, String password) async {
    return await authRepository.login(email, password);
  }

  Future<UserModel> register(String name, String email, String password) async {
    return await authRepository.register(name, email, password);
  }
}
