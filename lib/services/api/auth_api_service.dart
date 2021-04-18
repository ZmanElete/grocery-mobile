import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:grocery_list/app.dart';
import 'package:grocery_list/helpers/http_helpers.dart';
import 'package:grocery_list/models/config.dart';
import 'package:grocery_list/services/api/rest_service.dart';
import 'package:grocery_list/services/service_locator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {
  static AuthApiService get instance =>
      _instance != null ? _instance! : AuthApiService();
  static AuthApiService? _instance;

  static const ACCESS_TOKEN_KEY = 'auth_token';
  static const REFRESH_TOKEN_KEY = 'refresh_token';

  AuthApiService() {
    AuthApiService._instance = this;
  }

  // final String userUrl = "/auth/users/";
  final String loginUrl = "/login/";
  final String verifyUrl = "/login/verify/";
  final String refreshUrl = "/login/refresh/";

  final Config config = Config.instance;
  final SharedPreferences prefs = ServiceLocator.prefs;

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
  Future<void> login({required String email, required String password}) async {
    var login = {"email": email, "password": password};
    var response = await post(
      Uri.parse('${config.apiUrl}$loginUrl'),
      body: login,
    );
    HttpHelpers.checkError(response);
    var data = Map<String, String>.from(jsonDecode(response.body));
    prefs.setString(ACCESS_TOKEN_KEY, data['access']!);
    prefs.setString(REFRESH_TOKEN_KEY, data['refresh']!);
  }

  /// Returns whether the access token is valid or not
  Future<bool> verifyAccessToken() async {
    try {
      String? token = prefs.getString(ACCESS_TOKEN_KEY);
      if (token != null) {
        Response response = await post(
          Uri.parse('${config.apiUrl}$verifyUrl'),
          body: {
            'token': token,
          },
        );
        HttpHelpers.checkError(response);
        return true;
      }
      return false;
    } on HttpNotAuthorized {
      refreshAccessToken();
      return true;
    } catch (e) {
      throw (e);
    }
  }

  /// Returns whether the token was successfully refreshed or not
  Future<void> refreshAccessToken() async {
    String? token = prefs.getString(ACCESS_TOKEN_KEY);
    if (token == null)
      throw HttpNotAuthorized(
        Response(
          '{"detail": "Token is invalid or expired","code": "token_not_valid"}',
          401,
        ),
      );
    Response response = await post(
      Uri.parse('${config.apiUrl}$verifyUrl'),
      body: {
        'token': token,
      },
    );
    HttpHelpers.checkError(response);
    var data = Map<String, String>.from(jsonDecode(response.body));
    prefs.setString(ACCESS_TOKEN_KEY, data['access']!);
    prefs.setString(REFRESH_TOKEN_KEY, data['refresh']!);
  }

  void logout(context) async {
    prefs.remove(ACCESS_TOKEN_KEY);
    prefs.remove(REFRESH_TOKEN_KEY);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.LANDING_PAGE,
      (_) => false,
    );
  }
}
