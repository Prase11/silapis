import 'package:flutter/foundation.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/configs/config.dart';

class AuthState with ChangeNotifier {
  TokenModel tokenModel;
  bool isLogged = false;
  bool isLoading = false;
  bool showPassword = false;

  AuthState() {
    initData();
  }

  setToken(String accessToken, String refreshToken) async {
    await UtilPreferences.init();
    UtilPreferences.setString(Preferences.accessToken, accessToken);
    UtilPreferences.setString(Preferences.refreshToken, refreshToken);
    isLogged = true;

    setTokenModel();

    notifyListeners();
  }

  setTokenModel() async {
    await UtilPreferences.init();

    final token = UtilPreferences.getString(Preferences.accessToken);
    tokenModel = TokenModel.formJwt(token);
    UtilLogger.log('ACCESS TOKEN', tokenModel.toJson());
  }

  initData() async {
    try {
      ///Setup SharedPreferences
      await UtilPreferences.init();
      final hasToken = UtilPreferences.containsKey(Preferences.refreshToken);

      setTokenModel();

      if (hasToken) {
        isLogged = true;
      } else {
        isLogged = false;
      }

      notifyListeners();
    } catch (e) {
      UtilLogger.log('ADA ERROR CUY', e);
      notifyListeners();
    }
  }

  logout() async {
    // final token = UtilPreferences.getString(Preferences.accessToken);
    // UtilLogger.log('ACCESS TOKEN', TokenModel.formJwt(token).toJson());
    // return;

    await UtilPreferences.init();
    UtilPreferences.remove(Preferences.accessToken);
    UtilPreferences.remove(Preferences.refreshToken);
    isLogged = false;
    notifyListeners();
  }
}
