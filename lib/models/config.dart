class Config {
  static Config instance;

  final String apiUrl;
  final bool debug;
  final String debugLoginEmail;
  final String debugLoginPassword;

  Config({
    this.apiUrl,
    this.debug,
    this.debugLoginEmail,
    this.debugLoginPassword,
  });
}
