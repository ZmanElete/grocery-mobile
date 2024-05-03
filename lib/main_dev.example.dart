import 'package:flutter/material.dart';

import 'package:grocery_genie/app.dart';
import 'package:grocery_genie/models/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.instance = Config(
    apiUrl: 'http://192.168.0.111:8000',
    // apiUrl: 'http://guru-zachw:8000',
    debug: true,
    debugLoginEmail: 'test@test.com',
    debugLoginPassword: 'test',
  );
  runApp(const App());
}
