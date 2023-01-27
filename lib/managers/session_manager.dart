import 'dart:async';

import 'package:grocery_genie/managers/measurement_manager.dart';
import 'package:grocery_genie/models/user.dart';
import 'package:grocery_genie/services/api/auth_api_service.dart';
import 'package:grocery_genie/services/api/user_api_service.dart';

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
      return success;
    } catch (e) {
      //If the login is not successful it will error and leave this function here.
      // rethrow;
      return false;
    }
  }

  Future<void> _onSuccessfulLogin() async {
    MeasurementManager.instance.init();
    final user = await UserApiService.instance.current();
    _userStreamController.add(user);
  }

  Stream<User> _userStream() async* {
    if (user != null) yield user!;
    await for (final user in _userStreamController.stream) {
      yield user;
    }
  }

  void dispose() {
    _userStreamController.close();
  }
}
