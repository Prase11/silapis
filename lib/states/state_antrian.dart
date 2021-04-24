import 'package:flutter/foundation.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/logger.dart';

class AntrianKunjunganState with ChangeNotifier, DiagnosticableTreeMixin {
  AntrianListModel antrianList;
  Map<String, dynamic> error;
  bool isEmpty = false;

  AntrianKunjunganState() {
    initData();
  }

  Future<void> initData() async {
    final data = await SilakiRepository.getAntrian('Kunjungan');

    isEmpty = false;
    if (data.code == CODE.SUCCESS) {
      antrianList = AntrianListModel.fromJson(data.data);
      isEmpty = antrianList.list.length == 0;
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

class AntrianPenitipanState with ChangeNotifier, DiagnosticableTreeMixin {
  AntrianListModel antrianList;
  Map<String, dynamic> error;
  bool isEmpty = false;

  AntrianPenitipanState() {
    initData();
  }

  Future<void> initData() async {
    final data = await SilakiRepository.getAntrian('Penitipan');

    isEmpty = false;
    if (data.code == CODE.SUCCESS) {
      antrianList = AntrianListModel.fromJson(data.data);
      isEmpty = antrianList.list.length == 0;
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
