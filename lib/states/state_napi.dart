import 'package:flutter/foundation.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/logger.dart';

class NapiState with ChangeNotifier, DiagnosticableTreeMixin {
  NapiListModel napiList;
  Map<String, dynamic> error;
  bool isLoading = false;

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> findData(String napiNama) async {
    if (napiNama.isEmpty) {
      napiList = NapiListModel.fromJson({'rows': []});
      notifyListeners();
      return;
    }

    setLoading(true);
    final data = await SilakiRepository.getNapi(napiNama);
    if (data.code == CODE.SUCCESS) {
      napiList = NapiListModel.fromJson(data.data);

      notifyListeners();
      UtilLogger.log('DATA', napiList.list.map((e) => e.toJson()));
    } else {
      error = data.message;
      notifyListeners();
    }
    setLoading(false);
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
