// To parse this JSON data, do
//
//     final antrianModel = antrianModelFromJson(jsonString);

import 'dart:convert';

import 'package:silapis/utils/utils.dart';

AntrianModel antrianModelFromJson(String str) =>
    AntrianModel.fromJson(json.decode(str));

String antrianModelToJson(AntrianModel data) => json.encode(data.toJson());

AntrianListModel antrianlFromJson(String str) =>
    AntrianListModel.fromJson(json.decode(str));

class AntrianListModel {
  List<AntrianModel> list;

  AntrianListModel(this.list);

  factory AntrianListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return AntrianModel.fromJson(item);
    }).toList();

    return AntrianListModel(list);
  }
}

class AntrianModel {
  AntrianModel({
    this.pengunjung,
    this.id,
    this.no,
    this.nik,
    this.tanggal,
    this.jenis,
    this.deviceId,
    this.createdAt,
  });

  Pengunjung pengunjung;
  String id;
  String no;
  String nik;
  DateTime tanggal;
  String jenis;
  String deviceId;
  String createdAt;

  factory AntrianModel.fromJson(Map<String, dynamic> json) => AntrianModel(
        pengunjung: Pengunjung.fromJson(json["pengunjung"]),
        id: json["id"],
        no: json["no"].toString().padLeft(3, '0'),
        nik: json["nik"],
        tanggal: DateTime.parse(json["tanggal"]),
        jenis: json["jenis"],
        deviceId: json["deviceId"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "pengunjung": pengunjung.toJson(),
        "id": id,
        "no": no,
        "nik": nik,
        "tanggal": tanggal.toIso8601String(),
        "jenis": jenis,
        "deviceId": deviceId,
        "createdAt": createdAt,
      };

  String humanDate() {
    try {
      return unixTimeStampToDateTime(tanggal.millisecondsSinceEpoch);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}

class Pengunjung {
  Pengunjung({
    this.nik,
    this.nama,
    this.namaWbp,
    this.namaAyah,
  });

  String nik;
  String nama;
  String namaWbp;
  String namaAyah;

  factory Pengunjung.fromJson(Map<String, dynamic> json) => Pengunjung(
        nik: json["nik"],
        nama: json["nama"],
        namaWbp: json["namaWbp"],
        namaAyah: json["namaAyah"],
      );

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "nama": nama,
        "namaWbp": namaWbp,
        "namaAyah": namaAyah,
      };
}
