import 'dart:async';

import 'package:grocery_list/managers/measurement_manager.dart';
import 'package:grocery_list/models/user.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';
import 'package:grocery_list/services/api/user_api_service.dart';

class SessionManager {
  static SessionManager instance = SessionManager();

  SessionManager() {
    _userStreamController.stream.listen((event) => user = event);
  }

  final authApiService = AuthApiService.instance;
  User? user;
  final StreamController<User> _userStreamController = StreamController.broadcast();
  Stream<User?> get userStream => _userStream();

  Future<void> login({required String email, required String password}) async {
    try {
      await authApiService.login(email: email, password: password);
      await _onSuccessfulLogin();
    } catch (e) {
      //If the login is not successful it will error and leave this function here.
      rethrow;
    }
  }

  Future<bool> autoLogin() async {
    bool success = false;
    try {
      success = await authApiService.verifyAccessToken();
      await _onSuccessfulLogin();
    } catch (e) {
      //If the login is not successful it will error and leave this function here.
      rethrow;
    }
    return success;
  }

  Future<void> _onSuccessfulLogin() async {
    MeasurementManager.instance.init();
    var user = await UserApiService.instance.current();
    _userStreamController.add(user);
  }

  Stream<User> _userStream() async* {
    if (user != null) yield user!;
    await for (var user in _userStreamController.stream) {
      yield user;
    }
  }

  dispose() {
    _userStreamController.close();
  }
}
