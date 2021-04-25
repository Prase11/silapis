class Preferences {
  static String sosmed = 'sosmed';
  static String fotoBeranda = 'foto_beranda';
  static String settingSilaki = 'setting_silaki';
  static String mekanisme = 'mekanisme';

  ///Singleton factory
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();
}
