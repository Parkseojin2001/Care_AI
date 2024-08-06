import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> sendToServer(String text) async {
    final response = await http.post(
      Uri.parse('~~~~~~~~~~~'), // local IP
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'text': text,
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Data sent to server: $text');
    } else {
      print('Failed to send data to server $text');
    }
  }
}
