import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static Future<http.Response> login({
    required String id,
    required String password,
  }) async {
    return await http.post(
      Uri.parse('http://your-django-backend/api/login/'), // backend url로 교체
      headers: <String, String>{
        'Content-Type': 'application/json; charset = UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'id': id,
          'password': password,
        },
      ),
    );
  }
}
