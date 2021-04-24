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

  Future<User> current() async {
    //Retrieve always uses the request.user.id as the pk.
    return get(0);
  }
  //Only super users can user the delete function
  //All 'user' endpoints are filtered down to only the user that is accessing them.
}
