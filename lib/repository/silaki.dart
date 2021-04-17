import 'dart:async';
import 'package:dio/dio.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/configs/config.dart';

class SilakiRepository {
  ///Singleton factory
  static final SilakiRepository _instance = SilakiRepository._internal();

  factory SilakiRepository() {
    return _instance;
  }

  SilakiRepository._internal();

  // Ambil list / riwayat presensi
  Future<ApiModel> getAntrian() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/antrian.json");
    return ApiModel.fromJson(result);

    return await Consumer()
        .join(['pengunjung']).orderBy({'tanggal': 'DESC'}).execute(
            url: '/antrian?with[]=pengunjung&tanggal[sort]=DESC');
  }

  // String getToken() {
  //   String token = UtilPreferences.getToken()['accessToken'];
  //   print('GET TOKEN');
  //   print(UtilLogger.convert(parseJwt(token)));
  //   return UtilPreferences.getToken()['refreshToken'];
  // }

  // Map<String, dynamic> getUser() {
  //   String token = UtilPreferences.getToken()['accessToken'];
  //   Map<String, dynamic> decode =
  //       json.decode(UtilLogger.convert(parseJwt(token)));

  //   return decode[Preferences.user];
  // }
}
