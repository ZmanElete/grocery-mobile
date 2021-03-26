import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:grocery_list/app.dart';
import 'package:grocery_list/services/api/rest_service.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/landing.dart';
import '../service_locator.dart';

class AuthApiService {
  static AuthApiService get instance =>
      _instance != null ? _instance! : AuthApiService();
  static AuthApiService? _instance;

  static const ACCESS_TOKEN_KEY = 'auth_token';
  static const REFRESH_TOKEN_KEY = 'refresh_token';

  AuthApiService() {
    AuthApiService._instance = this;
    init();
  }

  void init() async {
    prefs = SharedPreferences.getInstance();
  }

  // final String userUrl = "/auth/users/";
  final String loginUrl = "/login/";
  final String verifyUrl = "/login/verify/";
  final String refreshUrl = "/login/refresh/";

  final Dio dio = ServiceLocator.instance;
  Future<SharedPreferences> prefs;

  // Future<Response> createUser({String username, String email, String password}) async {
  //   try {
  //     var resp = await dio.post(userUrl, data: {"username": username, "email": email, "password": password});
  //     var data = Map<String, dynamic>.from(resp.data);
  //     return await login(username: data['username'], password: password);
  //   } on DioError catch (e) {
  //     return e.response;
  //   }
  // }

  /// Returns whether it was a successful login or not
  Future<bool> login({String email, String password}) async {
    try {
      var login = {"email": email, "password": password};
      var resp = await dio.post(loginUrl, data: login);
      if (resp.statusCode != 200) return false;
      var data = Map<String, String>.from(resp.data);
      (await prefs).setString(ACCESS_TOKEN_KEY, data['access']);
      (await prefs).setString(REFRESH_TOKEN_KEY, data['refresh']);
      return true;
    } on DioError {
      return false;
    }
  }

  /// Returns whether the access token is valid or not
  Future<bool> verifyAccessToken() async {
    try {
      String token = (await prefs).getString(ACCESS_TOKEN_KEY);
      if (token == null) return false;
      Response resp = await dio.post(verifyUrl, data: {
        'token': token,
      });
      if (resp.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      if (await checkForRefresh(e)) return verifyAccessToken();
      return false;
    }
  }

  /// Returns whether the token was successfully refreshed or not
  Future<bool> refreshAccessToken() async {
    try {
      String token = (await prefs).getString(REFRESH_TOKEN_KEY);
      if (token == null) return false;
      Response resp = await dio.post(refreshUrl, data: {
        'refresh': token,
      });
      if (resp.statusCode != 200) return false;
      (await prefs).setString(ACCESS_TOKEN_KEY, resp.data['access']);
      (await prefs).setString(REFRESH_TOKEN_KEY, resp.data['refresh']);
      return true;
    } on DioError {
      return false;
    }
  }

  /// Check for refresh if dio error occurs.
  Future<bool> checkForRefresh(HttpErrorBase e) async {
    if (e.response.statusCode == 401) {
      return await refreshAccessToken();
    }
    return false;
  }

  void logout(context) async {
    (await prefs).remove(ACCESS_TOKEN_KEY);
    (await prefs).remove(REFRESH_TOKEN_KEY);
    Navigator.pushReplacementNamed(context, AppRoutes.LANDING_PAGE);
  }
}
