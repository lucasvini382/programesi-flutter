import 'package:programesi/model/user.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthService {
  Future<UserModel> login(String? email, String? password) async {

    var url =
        Uri.https('spring-java-programesi.herokuapp.com', '/api/user/login');
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
