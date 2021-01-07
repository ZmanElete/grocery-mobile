import 'package:grocery_list/models/api_model.dart';

import 'household.dart';

class User extends ApiModel{
  int id;
  String email;
  Household household;

  User();
  User.fromMap(Map<String, dynamic> map) {
    this.loadMap(map);
  }

  @override
  ApiModel clone() {
    return User()
      ..id=this.id
      ..email=this.email
      ..household=this.household;
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.email = map['email'];
    this.household = Household.fromMap(map['household']);
  }

  @override
  get pk => this.id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'household': this.household.toMap(),
    };
  }
}
