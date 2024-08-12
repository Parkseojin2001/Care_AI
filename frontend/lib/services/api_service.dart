import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> sendToServer(
      String text, List messages, String page) async {
    String length = messages.length.toString();
    final response = await http.post(
      Uri.parse('http://34.64.145.130:8000/chatbot/send/'), // GCP IP
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'text': text,
          'length': length,
          'page': page,
        },
      ),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['message'];
    } else {
      return "Sorry, Failed to load message from server";
    }
  }
}
