import 'package:flutter/material.dart';

import 'package:grocery_genie/app.dart';
import 'package:grocery_genie/models/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.instance = Config(
    apiUrl: '',
    debug: false,
  );
  runApp(const App());
}
