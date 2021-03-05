import 'package:flutter/material.dart';
import 'models/config.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.instance = Config(
    apiUrl: '',
    debug: false,
  );
  runApp(App());
}
