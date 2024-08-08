import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static Future<http.Response> login({
    required String id,
    required String password,
  }) async {
    return await http.post(
      Uri.parse('http://172.30.1.88:8000/accounts/'), // login-backend url로 교체
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
    required String email,
    required String password,
    required String username,
  }) async {
    return await http.post(
      Uri.parse(
          'http://172.30.1.65:8000/accounts/signup/'), // join-backend url로 교체
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
        'username': username,
        'email': email,
      }),
    );
  }
}
