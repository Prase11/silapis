class Environment {
  static const bool DEBUG = true;

  static const String APP_NAME = 'SILAKI';
  static const String VERSION = '1.0.0';
  static const int VERSION_CODE = 1;

  // PRIMARY CONFIGS
  static String apiUrl = 'http://192.168.43.247/api-siapps/public/api';
  static String apiKey = '605dafe39ee0780e8cf2c829434eea99';
  static String apiId = 'SILAKI';
  static int apiTimeout = 20;

  ///Singleton factory
  static final Environment _instance = Environment._internal();

  factory Environment() {
    return _instance;
  }

  Environment._internal();
}
