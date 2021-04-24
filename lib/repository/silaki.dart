import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/models/model.dart';

class SilakiRepository {
  // UtilLogger.log('DEVICE INFO', await UtilDeviceInfo.getId());

  static Future<ApiModel> getAntrian([String jenis = 'Penitipan']) async {
    // await Future.delayed(Duration(seconds: 1));
    // final result = await UtilAsset.loadJson("assets/data/antrian.json");
    // return ApiModel.fromJson(result);
    String deviceId = await UtilDeviceInfo.getId();

    return await Consumer().join(['pengunjung']).execute(
        url:
            '/antrian?with[]=pengunjung&with[]=napi&deviceId[eq]=$deviceId&tanggal[sort]=DESC&jenis[eq]=$jenis');
  }

  static Future<ApiModel> postAntrian(Map<String, dynamic> data) async {
    data['deviceId'] = await UtilDeviceInfo.getId();
    FormData formData = new FormData.fromMap(data);

    return await Consumer().execute(
        url: '/antrian', formData: formData, method: MethodRequest.POST);

    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/antrian_post.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> jadwalUmum() async {
    return await Consumer().execute(url: '/jadwal_umum');

    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/jadwal_umum.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> jadwalKhusus() async {
    return await Consumer().execute(url: '/jadwal_khusus');

    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/jadwal_khusus.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> layananPengaduan() async {
    return await Consumer().execute(url: '/layanan_pengaduan');

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

  static Future<ApiModel> getNapi(String napiNama) async {
    return await Consumer().execute(url: '/napi?nama[like]=$napiNama');

    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/napi.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> getBerita() async {
    return await Consumer().execute(url: '/berita');

    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/berita.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> getSetting() async {
    // return await Consumer().execute(url: '/setting');

    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/setting.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> getMekanisme() async {
    // return await Consumer().execute(url: '/setting');

    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/mekanisme.json");
    return ApiModel.fromJson(result);
  }

  static Future<ApiModel> getFotoBeranda() async {
    // return await Consumer().execute(url: '/setting');

    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/foto_beranda.json");
    return ApiModel.fromJson(result);
  }

  //Singleton factory
  static final SilakiRepository _instance = SilakiRepository._internal();

  factory SilakiRepository() {
    return _instance;
  }

  SilakiRepository._internal();
}
