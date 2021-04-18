import 'package:flutter/foundation.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/logger.dart';

class LayananState with ChangeNotifier, DiagnosticableTreeMixin {
  LayananPengaduanListModel layananPengaduanList;
  Map<String, dynamic> error;

  LayananState() {
    initData();
  }

  Future<void> initData() async {
    final data = await SilakiRepository.layananPengaduan();
    if (data.code == CODE.SUCCESS) {
      layananPengaduanList = LayananPengaduanListModel.fromJson(data.data);
      notifyListeners();
      UtilLogger.log('DATA', layananPengaduanList.list.map((e) => e.toJson()));
    } else {
      error = data.message;
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    error = null;
    layananPengaduanList = null;
    notifyListeners();
    initData();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
