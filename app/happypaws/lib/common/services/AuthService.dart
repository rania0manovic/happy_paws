import 'package:happypaws/common/services/BaseService.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends BaseService {
  AuthService() : super("Auth");

  Future<dynamic> signIn(dynamic data) async {
    final response = await post('/SignIn', data);
    return response;
  }

  Future<dynamic> sendEmailVerification(dynamic data) async {
    final response = await post('/SendEmailVerification', data);
    return response;
  }

  Future<dynamic> signUp(dynamic data) async {
    final response = await post('/SignUp', data);
    return response;
  }

  Future<dynamic> updatePassword(dynamic data) async {
    final response = await put('/UpdatePassword', data);
    return response;
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    if (token != null) {
      try {
        final Map<String, dynamic> decoded = Jwt.parseJwt(token);
        return decoded;
      } catch (e) {
        rethrow;
      }
    }

    return null;
  }

  Future<dynamic> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    if (token != null) {
      return token;
    }

    return null;
  }

  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}
