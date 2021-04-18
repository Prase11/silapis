import 'package:flutter/foundation.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/logger.dart';

class JadwalKhususState with ChangeNotifier, DiagnosticableTreeMixin {
  JadwalKhususListModel data;
  Map<String, dynamic> error;

  JadwalKhususState() {
    initData();
  }

  Future<void> initData() async {
    final res = await SilakiRepository.jadwalKhusus();
    if (res.code == CODE.SUCCESS) {
      data = JadwalKhususListModel.fromJson(res.data);
      notifyListeners();
      UtilLogger.log('DATA', data.list.map((e) => e.toJson()));
    } else {
      error = res.message;
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    error = null;
    data = null;
    notifyListeners();
    initData();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
