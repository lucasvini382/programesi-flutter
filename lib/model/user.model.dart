class UserModel extends User {
  UserModel({this.firstName, this.lastName, this.email});

  String? firstName;

  String? lastName;

  String? email;

  UserModel.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'];
}

abstract class User {}
