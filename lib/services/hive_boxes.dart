

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveBoxes {
  Box settings;

  Future<HiveBoxes> init() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);

    settings = await Hive.openBox('settings');

    return this;
  }
}
