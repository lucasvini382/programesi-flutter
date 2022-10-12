import 'package:programesi/model/user.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthService {
  Future<User> login(String? email, String? password) async {
    final Map<String, dynamic> data = {
      "login": email,
      "password": password,
      "systemId": "seller",
    };

    var url = Uri.https('4ffd-45-191-107-15.ngrok.io', '/api/user/login');
    final Map<String, String> header = {
      "login": email ?? '',
      "password": password ?? '',
    };
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: header);

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return UserModel.fromJson(jsonResponse);
  }
}
