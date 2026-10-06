import 'dart:convert';
import 'package:deliveryapp/utils/const_string.dart';
import 'package:http/http.dart' as http;

class ApiPost {
  static Future<http.Response> postRequest(
      String endpoint, dynamic bod, bool auth, String token) async {
    String token = "";
    final url = Uri.parse(BaseUrl + endpoint);
    final header = auth
        ? {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }
        : {
            'Content-Type': 'application/json',
          };

    final body = jsonEncode(bod);

    final response = await http.post(url, headers: header, body: body);

    return response;
  }
}
