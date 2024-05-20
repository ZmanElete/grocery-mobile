import 'package:flutter/widgets.dart';
import 'package:grocery_genie/app.dart';
import 'package:grocery_genie/models/config.dart';
import 'package:guru_provider/guru_provider/repository.dart';

Future<void> initAndRun(Config config) async {
  WidgetsFlutterBinding.ensureInitialized();
  Repository.instance.set(Config.key, config);

  runApp(const App());
}
