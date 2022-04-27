import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/config.dart';

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
