import 'package:grocery_list/models/user.dart';
import 'package:grocery_list/services/api/rest_service.dart';

class UserApiService extends RestService<User> {
  static UserApiService get instance =>
      _instance != null ? _instance! : UserApiService();
  static UserApiService? _instance;

  UserApiService()
      : super(
          apiModelCreator: (map) => User.fromMap(map),
          resource: 'user',
        ) {
    _instance = this;
  }
}
