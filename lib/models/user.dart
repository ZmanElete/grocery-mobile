import 'package:guru_flutter_rest/django/api_model.dart';

import 'package:grocery_genie/models/household.dart';

class User extends ApiModel {
  int? id;
  String email;
  Household household;

  User({this.id, required this.email, required this.household});
  User.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email']!,
        household = Household.fromJson(map['household']);

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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'household': household.toJson(),
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email']!;
    household = Household.fromJson(map['household']);
  }
}
