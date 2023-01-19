import 'package:flutter/material.dart';

import 'package:grocery_genie/app.dart';
import 'package:grocery_genie/models/config.dart';
import 'package:grocery_genie/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.instance = Config(
    apiUrl: '',
    debug: false,
  );
  await ServiceLocator.init();
  runApp(const App());
}
