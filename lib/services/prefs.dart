import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

StateKey<Future<SharedPreferences>> prefsKey = StateKey(() => SharedPreferences.getInstance());