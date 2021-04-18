import 'package:flutter/foundation.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/logger.dart';

class AntrianState with ChangeNotifier, DiagnosticableTreeMixin {
  AntrianListModel antrianList;
  Map<String, dynamic> error;

  AntrianState() {
    initData();
  }

  Future<void> initData() async {
    final data = await SilakiRepository.getAntrian();
    if (data.code == CODE.SUCCESS) {
      antrianList = AntrianListModel.fromJson(data.data);
      notifyListeners();
      UtilLogger.log('DATA', antrianList.list.map((e) => e.toJson()));
    } else {
      error = data.message;
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    error = null;
    antrianList = null;
    notifyListeners();
    initData();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
