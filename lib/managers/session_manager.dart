import 'dart:async';

import 'package:grocery_genie/managers/measurement_manager.dart';
import 'package:grocery_genie/models/user.dart';
import 'package:grocery_genie/services/auth_api_service.dart';
import 'package:grocery_genie/services/user_api_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class SessionManager {
  static StateKey<SessionManager> key = StateKey(() => SessionManager());
  static StateKey<User?> userKey = StateKey(() => null);

  SessionManager();

  final authApiService = Repository.instance.read(AuthApiService.key);
  bool get loggedIn => Repository.instance.read(userKey) != null;

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
    final user = await Repository.instance.read(UserApiService.key).current();
    Repository.instance.read(MeasurementListManager.key).init();
    Repository.instance.set(userKey, user);
  }
}
