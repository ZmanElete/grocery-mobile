import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveBoxes {
  static HiveBoxes get instance => _instance != null ? _instance : _instance = HiveBoxes();
  static HiveBoxes _instance;

  Box settings;

  HiveBoxes() {
    init();
  }

  Future<HiveBoxes> init() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);

    settings = await Hive.openBox('settings');

    return this;
  }
}
