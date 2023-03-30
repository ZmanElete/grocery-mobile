// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grocery_genie/models/config.dart';

abstract class ServiceLocator {
  static SharedPreferences get prefs => _prefs!;
  static SharedPreferences? _prefs;

  static Dio get dio => _dio!;
  static Dio? _dio;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _dio = Dio(BaseOptions(baseUrl: Config.instance.apiUrl));
  }
}
