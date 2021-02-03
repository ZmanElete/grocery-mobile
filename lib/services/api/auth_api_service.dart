import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_list/pages/landing.dart';
import 'package:hive/hive.dart';

import '../hive_boxes.dart';

class AuthApiService {
  // final String userUrl = "/auth/users/";
  final String loginUrl = "/login/";
  final String verifyUrl = "/login/verify/";
  final String refreshUrl = "/login/refresh/";

  static const ACCESS_TOKEN_KEY = 'auth_token';
  static const REFRESH_TOKEN_KEY = 'refresh_token';

  final Dio dio = GetIt.instance.get<Dio>();
  final Box settings = GetIt.instance.get<HiveBoxes>().settings;

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
      var settings = GetIt.instance<HiveBoxes>().settings;
      settings.put(ACCESS_TOKEN_KEY, data['access']);
      settings.put(REFRESH_TOKEN_KEY, data['refresh']);
      return true;
    } on DioError {
      return false;
    }
  }

  /// Returns whether the access token is valid or not
  Future<bool> verifyAccessToken() async {
    try {
      String token = await settings.get(ACCESS_TOKEN_KEY);
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
      String token = await settings.get(REFRESH_TOKEN_KEY);
      if (token == null) return false;
      Response resp = await dio.post(refreshUrl, data: {
        'refresh': token,
      });
      if (resp.statusCode != 200) return false;
      settings.put(ACCESS_TOKEN_KEY, resp.data['access']);
      settings.put(REFRESH_TOKEN_KEY, resp.data['refresh']);
      return true;
    } on DioError {
      return false;
    }
  }

  /// Check for refresh if dio error occurs.
  Future<bool> checkForRefresh(DioError e) async {
    if (e.response?.statusCode == 401) {
      return await refreshAccessToken();
    }
    return false;
  }

  void logout(context) {
    settings.delete(ACCESS_TOKEN_KEY);
    settings.delete(REFRESH_TOKEN_KEY);
    Navigator.pushReplacementNamed(context, LandingPage.route);
  }
}
