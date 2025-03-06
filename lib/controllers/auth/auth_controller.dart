import 'package:dailyfairdeal/common_calls/handle_error_snackbar.dart';
import 'package:dailyfairdeal/common_calls/handle_success.dart';
import 'package:dailyfairdeal/config/messages.dart';
import 'package:dailyfairdeal/models/user/user_model.dart';
import '../../services/auth/auth_service.dart';

class AuthController{
  final AuthService authService;

  AuthController({required this.authService});


  Future<void> login(String email, String password) async {
    try {
      UserModel user = await authService.login(email, password);
      handleSuccessAuth(user, Messages.loginSuccess);
    } catch (e) {
      handleErrorSnackbar(e.toString());
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      UserModel user = await authService.register(name, email, password);
      handleSuccessAuth(user, Messages.registerSuccess);
    } catch (e) {
      handleErrorSnackbar(e.toString());
    }
  }
}
