class Environment {
  static const bool DEBUG = true;
  static const bool SHOW_LOG = true;

  static const String APP_NAME = 'SILAKI';
  static const String VERSION = '1.0.0';
  static const int VERSION_CODE = 1;

  // PRIMARY CONFIGS
  static String apiUrl = 'https://lapasnarkotikakalsel.com/public/api';
  static String apiKey = '1611016210001';
  static String apiId = 'SILAKI';
  static int apiTimeout = 10;

  ///Singleton factory
  static final Environment _instance = Environment._internal();

  factory Environment() {
    return _instance;
  }

  Environment._internal();
}
