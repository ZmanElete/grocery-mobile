import 'package:flutter/material.dart';
import 'models/config.dart';
import 'service_locator.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerServices(Config(
    apiUrl: '',
    debug: false
  ));
  runApp(App());
}
