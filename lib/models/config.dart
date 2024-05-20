import 'package:guru_provider/guru_provider/keys/state_key.dart';

class Config {
  static StateKey<Config> key = StateKey(() => Config(apiUrl: ''));

  final String apiUrl;
  final bool debug;
  final String? debugLoginEmail;
  final String? debugLoginPassword;
  final bool enableStorybook;

  Config({
    required this.apiUrl,
    this.enableStorybook = false,
    this.debug = false,
    this.debugLoginEmail,
    this.debugLoginPassword,
  });
}
