import 'package:flutter/material.dart';

import 'app.dart';
import 'models/config.dart';
import 'services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.instance = Config(
    apiUrl: 'http://192.168.0.111:8000',
    // apiUrl: 'http://guru-zachw:8000',
    debug: true,
    debugLoginEmail: 'test@test.com',
    debugLoginPassword: 'test',
  );
  await ServiceLocator.init();
  runApp(App());
}
