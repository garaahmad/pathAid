import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/networking/dio_factory.dart';
import '../../core/networking/api_service.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/models/login_request_body.dart';
import '../../features/auth/data/models/signup_request_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/networking/api_constants.dart';

class UserService {
  late AuthRepo _authRepo;

  static const String _baseUrl = ApiConstants.apiBaseUrl;

  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  UserService() {
    _initAuthRepo();
  }

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final response = await http
          .get(
            Uri.parse('${_baseUrl}users'),
            headers: _headers,
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);
        if (decodedData is List) {
          return decodedData.cast<Map<String, dynamic>>();
        } else if (decodedData is Map) {
          if (decodedData.containsKey('data')) {
            final data = decodedData['data'];
            if (data is List) {
              return data.cast<Map<String, dynamic>>();
            } else if (data is Map && data.containsKey('users')) {
              return (data['users'] as List).cast<Map<String, dynamic>>();
            }
          } else if (decodedData.containsKey('users')) {
            final users = decodedData['users'];
            if (users is List) {
              return users.cast<Map<String, dynamic>>();
            }
          }
        }
        return [];
      } else {
        try {
          final error = json.decode(response.body);
          throw Exception(error['message'] ?? error['info'] ?? 'فشل جلب المستخدمين');
        } catch (e) {
          if (e.toString().contains('فشل جلب')) rethrow;
          throw Exception('فشل الخادم: كود ${response.statusCode}');
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}users'),
        headers: _headers,
        body: json.encode(userData),
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 201 || response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('فشل إنشاء المستخدم: كود ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> updateUser(int userId, Map<String, dynamic> userData) async {
    try {
      final response = await http.put(
        Uri.parse('${_baseUrl}users/$userId'),
        headers: _headers,
        body: json.encode(userData),
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('فشل تحديث المستخدم: كود ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteUser(int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('${_baseUrl}users/$userId'),
        headers: _headers,
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('فشل حذف المستخدم: كود ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getAvailableDriversForRequest(int requestId) async {
    try {
      final response = await http
          .get(
            Uri.parse('${_baseUrl}users/drivers/available-for-request/$requestId'),
            headers: _headers,
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);
        if (decodedData is List) {
          return decodedData.cast<Map<String, dynamic>>();
        } else if (decodedData is Map && decodedData.containsKey('data')) {
          return (decodedData['data'] as List).cast<Map<String, dynamic>>();
        }
        return [];
      } else {
        try {
          final error = json.decode(response.body);
          throw Exception(error['info'] ?? 'فشل جلب السائقين المتاحين');
        } catch (e) {
          if (e.toString().contains('فشل جلب')) rethrow;
          throw Exception('فشل الخادم: كود ${response.statusCode}');
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _initAuthRepo() async {
    final dio = await DioFactory.getDio();
    final apiService = ApiService(dio);
    _authRepo = AuthRepo(apiService);
  }

  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _initAuthRepo();
      final body = SignupRequestBody(name: name, email: email, password: password);
      final response = await _authRepo.signup(body);

      if (response?.status == "success") {
        return {'success': true, 'data': response?.data?.user?.toJson()};
      } else {
        return {'success': false, 'message': 'فشل إنشاء الحساب'};
      }
    } catch (e) {
      return {'success': false, 'message': 'حدث خطأ في الاتصال: \$e'};
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _initAuthRepo();
      final body = LoginRequestBody(email: email, password: password);
      final response = await _authRepo.login(body);

      if (response?.status == "success") {
        return {'success': true, 'data': response?.data?.user?.toJson()};
      } else {
        return {'success': false, 'message': 'البريد الإلكتروني أو كلمة المرور غير صحيحة'};
      }
    } catch (e) {
      return {'success': false, 'message': 'حدث خطأ في الاتصال: \$e'};
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final token = await _getToken();
      if (token == null) {
        return {'success': false, 'message': 'أنت غير مسجل الدخول'};
      }

      await _initAuthRepo();
      final response = await _authRepo.getUserProfile();

      if (response?.status == "success") {
        return {'success': true, 'data': response?.data?.user?.toJson()};
      } else {
        return {'success': false, 'message': 'فشل في جلب البيانات'};
      }
    } catch (e) {
      return {'success': false, 'message': 'حدث خطأ في الاتصال: \$e'};
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
