import 'package:flutter/material.dart';
import 'package:programesi/model/user.model.dart';
import 'package:programesi/view_model/services/auth.service.dart';

class UserViewModel with ChangeNotifier {
  String? firstName;

  String? lastName;

  String? email;

  List<TimeworkModel>? timeworks;

  Future<UserModel> loginUser(String? email, String? password) async {
    UserModel user = await AuthService().login(email, password);
    firstName = user.firstName;
    lastName = user.lastName;
    email = user.email;
    timeworks = user.timeworks;
    notifyListeners();
    return user;
  }
}
