import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  static SharedPreferences get prefs => _prefs!;
  static SharedPreferences? _prefs;

  ServiceLocator() {
    init();
  }

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
