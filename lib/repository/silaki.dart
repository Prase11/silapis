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

  static Future<ApiModel> postAntrian(Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/antrian_post.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> jadwalUmum() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/jadwal_umum.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> jadwalKhusus() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/jadwal_khusus.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> layananPengaduan() async {
    await Future.delayed(Duration(seconds: 1));
    final result =
        await UtilAsset.loadJson("assets/data/layanan_pengaduan.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> getPegawai() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/pegawai.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> getBerita() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/berita.json");
    return ApiModel.fromJson(result);
  }

  //Singleton factory
  static final SilakiRepository _instance = SilakiRepository._internal();

  factory SilakiRepository() {
    return _instance;
  }

  SilakiRepository._internal();
}
