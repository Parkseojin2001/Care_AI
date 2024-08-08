import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> sendToServer(String text, List messages) async {
    String length = messages.length.toString();
    final response = await http.post(
      Uri.parse('http://172.30.1.16:8000/chatbot/send/'), // local IP
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'text': text,
          'length': length,
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
