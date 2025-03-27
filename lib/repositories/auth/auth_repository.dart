import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/interfaces/auth/i_auth_repository.dart';
import 'package:dailyfairdeal/models/user/user_model.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<UserModel> login(String email, String password) async {
    final requestBody = {"email": email, "password": password};
    return await ApiHelper.request<UserModel>(
      endpoint: AppUrl.loginEndpoint,
      method: "POST",
      body: requestBody,
      fromJson: (data) => UserModel.fromJson(data),
    );
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final requestBody = {"name": name, "email": email, "password": password};
    return await ApiHelper.request<UserModel>(
      endpoint: AppUrl.registerEndpoint,
      method: "POST",
      body: requestBody,
      fromJson: (data) => UserModel.fromJson(data),
    );
  }

  @override
  Future<String> logout() async { 
    final response = await ApiHelper.request<String>(
      endpoint: AppUrl.logoutEndpoint,
      method: "POST",
    );

    return response;
  }
}
