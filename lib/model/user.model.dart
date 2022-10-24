class UserModel extends User {
  UserModel({this.firstName, this.lastName, this.email, this.timeworks});

  String? firstName;

  String? lastName;

  String? email;

  List<TimeworkModel>? timeworks;

  UserModel.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        timeworks = List<TimeworkModel>.from(
          (json['timeworks'] as List).map<TimeworkModel>(
            (x) => TimeworkModel.fromMap(x as Map<String, dynamic>),
          ),
        );
}

class TimeworkModel {
  int? id;
  String? entryHour;
  String? exitHour;
  String? description;
  String? initials;
  List<CalendarModel>? calendars;

  TimeworkModel(
      {required this.id,
      required this.entryHour,
      required this.exitHour,
      required this.description,
      required this.initials,
      required this.calendars});

  factory TimeworkModel.fromMap(Map<String, dynamic> map) {
    return TimeworkModel(
        id: map['id'],
        entryHour: map['entryHour'],
        exitHour: map['exitHour'],
        description: map['description'],
        initials: map['initials'],
        calendars: List<CalendarModel>.from(
          (map['calendars'] as List).map<CalendarModel>(
            (x) => CalendarModel.fromMap(x as Map<String, dynamic>),
          ),
        ));
  }
}

class CalendarModel {
  int? id;
  String? date;

  CalendarModel({
    required this.id,
    required this.date,
  });

  factory CalendarModel.fromMap(Map<String, dynamic> map) {
    return CalendarModel(id: map['id'], date: map['date']);
  }
}

abstract class User {}
