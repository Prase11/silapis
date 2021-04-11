class Images {
  static const String Logo = "assets/images/logo.png";

  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
