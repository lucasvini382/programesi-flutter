import 'package:flutter/material.dart';
import 'package:programesi/model/user.model.dart';
import 'package:programesi/view_model/services/auth.service.dart';

class UserViewModel with ChangeNotifier {
  Future<User> loginUser(String? email, String? password) async {
    User user = await AuthService().login(email, password);

    return user;
  }
}
