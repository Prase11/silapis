import 'package:flutter/foundation.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/logger.dart';

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
            ?.foto ??
        '0';
  }

  Future<void> initSplash() async {
    await Future.delayed(Duration(seconds: 3));
    isSplash = false;
    notifyListeners();
  }

  Future<void> initData() async {
    try {
      final setting = await SilakiRepository.getSetting();
      final mekanisme = await SilakiRepository.getMekanisme();
      final fotoBeranda = await SilakiRepository.getFotoBeranda();
      final sosmed = await SilakiRepository.getSosmed();
      isSplash = false;

      if (setting.code == CODE.SUCCESS) {
        settingList = SettingListModel.fromJson(setting.data);
        notifyListeners();
        UtilLogger.log('DATA', settingList.list.map((e) => e.toJson()));
      }

      if (mekanisme.code == CODE.SUCCESS) {
        mekanismeList = MekanismeListModel.fromJson(mekanisme.data);
        notifyListeners();
        UtilLogger.log('DATA', mekanismeList.list.map((e) => e.toJson()));
      }

      if (fotoBeranda.code == CODE.SUCCESS) {
        fotoBerandaList = FotoBerandaListModel.fromJson(fotoBeranda.data);
        notifyListeners();
        UtilLogger.log('DATA', fotoBerandaList.list.map((e) => e.toJson()));
      }

      if (sosmed.code == CODE.SUCCESS) {
        sosmedList = SosmedListModel.fromJson(sosmed.data);
        notifyListeners();
        UtilLogger.log('DATA', sosmedList.list.map((e) => e.toJson()));
      }
    } catch (e) {
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
