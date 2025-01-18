import 'package:dailyfairdeal/common_calls/handle_request.dart';
import 'package:dailyfairdeal/interfaces/i_auth_repository.dart';
import 'package:dailyfairdeal/models/user_model.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<UserModel> login(String email, String password) async {
    final requestBody = {"email": email, "password": password};
    return await handleRequestAuth(AppUrl.loginEndpoint, requestBody);
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final requestBody = {"name": name, "email": email, "password": password};
    return await handleRequestAuth(AppUrl.registerEndpoint, requestBody);
  }
}
