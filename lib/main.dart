import 'package:flutter/material.dart';
import 'package:grocery_list/services/service_locator.dart';
import 'models/config.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.instance = Config(
    apiUrl: '',
    debug: false,
  );
  ServiceLocator();
  runApp(App());
}
