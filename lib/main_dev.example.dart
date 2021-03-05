import 'package:flutter/material.dart';
import 'models/config.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.instance = Config(
    apiUrl: 'http://192.168.0.111:8000',
    // apiUrl: 'http://guru-zachw:8000',
    debug: true,
    debugLoginEmail: 'test@test.com',
    debugLoginPassword: 'test',
  );
  runApp(App());
}
