import 'package:flutter/material.dart';
import 'models/config.dart';
import 'service_locator.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerServices(Config(
    apiUrl: 'http://ZUES-Z:8000',
    debug: true,
    debugLoginEmail: 'test@test.com',
    debugLoginPassword: 'test'
  ));
  runApp(App());
}
