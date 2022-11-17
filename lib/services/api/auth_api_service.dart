import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:grocery_list/helpers/http_helpers.dart';
import 'package:grocery_list/models/config.dart';
import 'package:grocery_list/pages/landing.dart';
import 'package:grocery_list/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {
  static AuthApiService get instance => _instance != null ? _instance! : AuthApiService();
  static AuthApiService? _instance;

  static const ACCESS_TOKEN_KEY = 'auth_token';
  static const REFRESH_TOKEN_KEY = 'refresh_token';

  AuthApiService() {
    _instance = this;
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
    var response = await ServiceLocator.dio.post(
      loginUrl,
      data: login,
    );
    HttpHelpers.checkError(response);
    var data = response.data;
    prefs.setString(ACCESS_TOKEN_KEY, data['access']!);
    prefs.setString(REFRESH_TOKEN_KEY, data['refresh']!);
  }

  /// Returns whether the access token is valid or not
  Future<bool> verifyAccessToken() async {
    try {
      String? token = prefs.getString(ACCESS_TOKEN_KEY);
      if (token != null) {
        Response response = await ServiceLocator.dio.post(
          verifyUrl,
          data: {
            'token': token,
          },
        );
        HttpHelpers.checkError(response);
        return true;
      }
      return false;
    } on HttpNotAuthorized {
      return await refreshAccessToken();
    }
  }

  /// Returns whether the token was successfully refreshed or not
  Future<bool> refreshAccessToken() async {
    try {
      String? token = prefs.getString(ACCESS_TOKEN_KEY);
      if (token == null) {
        throw HttpNotAuthorized(
          Response(
            data: {"detail": "Token is invalid or expired", "code": "token_not_valid"},
            statusCode: 401,
            requestOptions: RequestOptions(path: ''),
          ),
        );
      }
      Response response = await ServiceLocator.dio.post(
        refreshUrl,
        data: {
          'refresh': token,
        },
      );
      HttpHelpers.checkError(response);
      var data = response.data;
      prefs.setString(ACCESS_TOKEN_KEY, data['access']!);
      prefs.setString(REFRESH_TOKEN_KEY, data['refresh']!);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  void logout(context) async {
    prefs.remove(ACCESS_TOKEN_KEY);
    prefs.remove(REFRESH_TOKEN_KEY);
    Navigator.pushNamedAndRemoveUntil(
      context,
      LandingPage.route,
      (_) => false,
    );
  }
}
