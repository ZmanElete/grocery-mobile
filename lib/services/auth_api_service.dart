// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:grocery_genie/helpers/http_helpers.dart';
import 'package:grocery_genie/models/config.dart';
import 'package:grocery_genie/pages/landing.dart';
import 'package:grocery_genie/services/mixins/grocery_api_mixin.dart';
import 'package:grocery_genie/services/prefs.dart';
import 'package:guru_flutter_rest/django/rest_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService extends RestService with GroceryApiMixin {
  static StateKey<AuthApiService> key = StateKey(() => AuthApiService());

  static const ACCESS_TOKEN_KEY = 'auth_token';
  static const REFRESH_TOKEN_KEY = 'refresh_token';

  // final String userUrl = "/auth/users/";
  final String loginUrl = "/login/";
  final String verifyUrl = "/login/verify/";
  final String refreshUrl = "/login/refresh/";

  final Config config = Config.instance;
  final Future<SharedPreferences> prefs = Repository.instance.read(prefsKey);

  /// Returns whether it was a successful login or not
  Future<void> login({required String email, required String password}) async {
    try {
      final login = {"email": email, "password": password};
      final response = await dio.post(
        loginUrl,
        data: login,
      );

      final Map<String, dynamic> data = response.data;
      await prefs
        ..setString(ACCESS_TOKEN_KEY, data['access']!)
        ..setString(REFRESH_TOKEN_KEY, data['refresh']!);
    } on DioException catch (e) {
      checkError(e.response);
      rethrow;
    }
  }

  /// Returns whether the access token is valid or not
  Future<bool> verifyAccessToken() async {
    try {
      final String? token = (await prefs).getString(ACCESS_TOKEN_KEY);
      if (token != null) {
        final Response response = await dio.post(
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
      return refreshAccessToken();
    }
  }

  /// Returns whether the token was successfully refreshed or not
  Future<bool> refreshAccessToken() async {
    try {
      final String? token = (await prefs).getString(ACCESS_TOKEN_KEY);
      if (token == null) {
        throw HttpNotAuthorized(
          Response(
            data: {"detail": "Token is invalid or expired", "code": "token_not_valid"},
            statusCode: 401,
            requestOptions: RequestOptions(path: ''),
          ),
        );
      }
      final Response response = await dio.post(
        refreshUrl,
        data: {
          'refresh': token,
        },
      );
      HttpHelpers.checkError(response);
      final Map<String, dynamic> data = response.data;
      await prefs
        ..setString(ACCESS_TOKEN_KEY, data['access']!)
        ..setString(REFRESH_TOKEN_KEY, data['refresh']!);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> logout(context) async {
    await prefs
      ..remove(ACCESS_TOKEN_KEY)
      ..remove(REFRESH_TOKEN_KEY);
    Navigator.pushNamedAndRemoveUntil(
      context,
      LandingPage.route,
      (_) => false,
    );
  }
}
