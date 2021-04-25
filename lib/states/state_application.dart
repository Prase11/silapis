import 'package:flutter/foundation.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/configs/config.dart';

class ApplicationState with ChangeNotifier, DiagnosticableTreeMixin {
  SettingListModel settingList;
  MekanismeListModel mekanismeList;
  FotoBerandaListModel fotoBerandaList;
  SosmedListModel sosmedList;
  bool isSplash = true;

  ApplicationState() {
    // initSplash();
    initData();
  }

  String getSettingByKey(String key) {
    return settingList.list
            .firstWhere((e) => e.key == key, orElse: () => null)
            ?.value ??
        '0';
  }

  String getMekanismeByKey(String key) {
    key = key == 'Kunjungan' ? 'K001' : 'P001';
    return mekanismeList.list
            .firstWhere((e) => e.kode == key, orElse: () => null)
            ?.getImage() ??
        '0';
  }

  Future<void> initSplash() async {
    await Future.delayed(Duration(seconds: 3));
    isSplash = false;
    notifyListeners();
  }

  Future<void> initData() async {
    try {
      ///Setup SharedPreferences
      await UtilPreferences.init();

      // CACHED INIT DATA YANG LAMA JIKA SUDAH REQUEST
      if (UtilPreferences.containsKey(Preferences.settingSilaki)) {
        settingList = SettingListModel.fromRawJson(
            UtilPreferences.getString(Preferences.settingSilaki));
        UtilLogger.log(
            'CACHED SETTING', settingList.list.map((e) => e.toJson()));
      }

      if (UtilPreferences.containsKey(Preferences.mekanisme)) {
        mekanismeList = MekanismeListModel.fromRawJson(
            UtilPreferences.getString(Preferences.mekanisme));
        UtilLogger.log(
            'CACHED MEKANISME', mekanismeList.list.map((e) => e.toJson()));
      }

      if (UtilPreferences.containsKey(Preferences.fotoBeranda)) {
        fotoBerandaList = FotoBerandaListModel.fromRawJson(
            UtilPreferences.getString(Preferences.fotoBeranda));
        UtilLogger.log(
            'CACHED FotoBeranda', fotoBerandaList.list.map((e) => e.toJson()));
      }

      if (UtilPreferences.containsKey(Preferences.sosmed)) {
        sosmedList = SosmedListModel.fromRawJson(
            UtilPreferences.getString(Preferences.sosmed));
        UtilLogger.log('CACHED SOSMED', sosmedList.list.map((e) => e.toJson()));
        isSplash = false;
        await Future.delayed(Duration(seconds: 2));
      }
      // END CACHED
      //
      notifyListeners();

      final setting = await SilakiRepository.getSetting();
      final mekanisme = await SilakiRepository.getMekanisme();
      final fotoBeranda = await SilakiRepository.getFotoBeranda();
      final sosmed = await SilakiRepository.getSosmed();
      isSplash = false;

      if (setting.code == CODE.SUCCESS) {
        settingList = SettingListModel.fromJson(setting.data);
        UtilPreferences.setString(
            Preferences.settingSilaki, settingList.toString());
        notifyListeners();
        UtilLogger.log('SETTING', settingList.list.map((e) => e.toJson()));
      }

      if (mekanisme.code == CODE.SUCCESS) {
        mekanismeList = MekanismeListModel.fromJson(mekanisme.data);
        UtilPreferences.setString(
            Preferences.mekanisme, mekanismeList.toString());
        notifyListeners();
        UtilLogger.log('MEKANISME', mekanismeList.list.map((e) => e.toJson()));
      }

      if (fotoBeranda.code == CODE.SUCCESS) {
        fotoBerandaList = FotoBerandaListModel.fromJson(fotoBeranda.data);
        UtilPreferences.setString(
            Preferences.fotoBeranda, fotoBerandaList.toString());
        notifyListeners();
        UtilLogger.log(
            'FOTO BERANDA', fotoBerandaList.list.map((e) => e.toJson()));
      }

      if (sosmed.code == CODE.SUCCESS) {
        sosmedList = SosmedListModel.fromJson(sosmed.data);
        UtilPreferences.setString(Preferences.sosmed, sosmedList.toString());
        notifyListeners();
        UtilLogger.log('SOSMED', sosmedList.list.map((e) => e.toJson()));
      }
    } catch (e) {
      UtilLogger.log('ADA ERROR CUY', e);
      isSplash = false;
      notifyListeners();
    }
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
