import 'package:dio/dio.dart';
import 'package:grocery_list/models/config.dart';

class DioService {
  static Dio get instance => _instance != null ? _instance : init();
  static Dio _instance;

  DioService() {
    var config = Config.instance;
    _instance = Dio();
    _instance.options.baseUrl = config.apiUrl;
    _instance.options.connectTimeout = config.debug ? 60000 : 10000;
    _instance.options.receiveTimeout = 3000;
  }

  static Dio init() {
    DioService();
    return _instance;
  }
}
