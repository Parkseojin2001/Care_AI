import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static Future<http.Response> login({
    required String id,
    required String password,
  }) async {
    return await http.post(
      Uri.parse('~~~~~~~~~'), // login-backend url로 교체
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'id': id,
          'password': password,
        },
      ),
    );
  }

  static Future<http.Response> register({
    required String id,
    required String password,
    required String nickname,
  }) async {
    return await http.post(
      Uri.parse('~~~~~~~~'), // join-backend url로 교체
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'password': password,
        'nickname': nickname,
      }),
    );
  }
}
