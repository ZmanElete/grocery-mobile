import 'dart:async';

import 'package:grocery_list/managers/measurement_manager.dart';
import 'package:grocery_list/models/user.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';
import 'package:grocery_list/services/api/user_api_service.dart';

class SessionManager {
  static SessionManager instance = SessionManager();

  final authApiService = AuthApiService.instance;
  StreamController<User> _userStreamController = StreamController.broadcast();
  Stream<User> get user => _userStreamController.stream;

  Future<void> login({required String email, required String password}) async {
    try {
      await authApiService.login(email: email, password: password);
      await _onSuccessfulLogin();
    } catch (e) {
      //If the login is not successful it will error and leave this function here.
      throw (e);
    }
  }

  Future<void> autoLogin() async {
    try {
      await authApiService.verifyAccessToken();
      await _onSuccessfulLogin();
    } catch (e) {
      //If the login is not successful it will error and leave this function here.
      throw (e);
    }
  }

  Future<void> _onSuccessfulLogin() async {
    MeasurementManager.instance.init();
    var user = await UserApiService.instance.current();
    _userStreamController.add(user);
  }

  dispose() {
    _userStreamController.close();
  }
}
