import 'package:grocery_genie/init_run.dart';
import 'package:grocery_genie/models/config.dart';

void main() async {
  initAndRun(
    Config(
      apiUrl: 'http://192.168.0.111:8000',
      enableStorybook: true,
      // apiUrl: 'http://guru-zachw:8000',
      debug: true,
      debugLoginEmail: 'test@test.com',
      debugLoginPassword: 'test',
    ),
  );
}
