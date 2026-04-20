import '../../../../core/networking/api_service.dart';
import '../models/auth_response.dart';
import '../models/login_request_body.dart';
import '../models/signup_request_body.dart';

class AuthRepo {
  final ApiService _apiService;

  AuthRepo(this._apiService);

  Future<AuthResponse?> login(LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<AuthResponse?> signup(SignupRequestBody signupRequestBody) async {
    try {
      final response = await _apiService.signup(signupRequestBody);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<AuthResponse?> getUserProfile() async {
    try {
      final response = await _apiService.getUserProfile();
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
