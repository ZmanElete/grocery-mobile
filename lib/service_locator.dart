import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'models/config.dart';
import 'services/api/auth_api_service.dart';
import 'services/hive_boxes.dart';

Future<void> registerServices(Config config) async {
  var getit = GetIt.instance;
  getit.registerSingleton(config);
  var dio = Dio();
  dio.options.baseUrl = config.apiUrl;
  dio.options.connectTimeout = config.debug ? 60000 : 10000;
  dio.options.receiveTimeout = 3000;
  getit.registerSingleton(dio);

  getit.registerSingleton(AuthApiService());
  getit.registerSingleton(await HiveBoxes().init());
}
