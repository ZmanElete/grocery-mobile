import 'package:grocery_list/models/api_model.dart';

import 'household.dart';

class User extends ApiModel {
  int? id;
  String email;
  Household household;

  User({this.id, required this.email, required this.household});
  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email']!,
        household = Household.fromMap(map['household']);

  @override
  User clone() {
    return User(
      id: id,
      email: email,
      household: household,
    );
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'household': household.toMap(),
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email']!;
    household = Household.fromMap(map['household']);
  }
}
