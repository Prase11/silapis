import 'dart:async';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/models/model.dart';

class SilakiRepository {
  // UtilLogger.log('DEVICE INFO', await UtilDeviceInfo.getId());

  static Future<ApiModel> getAntrian() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/antrian.json");
    return ApiModel.fromJson(result);

    return await Consumer()
        .join(['pengunjung']).orderBy({'tanggal': 'DESC'}).execute(
            url: '/antrian?with[]=pengunjung&tanggal[sort]=DESC');
  }

  //Singleton factory
  static final SilakiRepository _instance = SilakiRepository._internal();

  factory SilakiRepository() {
    return _instance;
  }

  SilakiRepository._internal();
}
