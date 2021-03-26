class Config {
  //So that it is never null
  static Config instance = Config(apiUrl: '');

  final String apiUrl;
  final bool debug;
  final String? debugLoginEmail;
  final String? debugLoginPassword;

  Config({
    required this.apiUrl,
    this.debug = false,
    this.debugLoginEmail,
    this.debugLoginPassword,
  });
}
