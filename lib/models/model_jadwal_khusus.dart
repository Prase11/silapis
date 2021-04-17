// To parse this JSON data, do
//
//     final jadwalKhususModel = jadwalKhususModelFromJson(jsonString);

import 'dart:convert';

import 'package:silapis/utils/utils.dart';

JadwalKhususModel jadwalKhususModelFromJson(String str) =>
    JadwalKhususModel.fromJson(json.decode(str));

String jadwalKhususModelToJson(JadwalKhususModel data) =>
    json.encode(data.toJson());

class JadwalKhususListModel {
  List<JadwalKhususModel> list;

  JadwalKhususListModel(this.list);

  factory JadwalKhususListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return JadwalKhususModel.fromJson(item);
    }).toList();

    return JadwalKhususListModel(list);
  }
}

class JadwalKhususModel {
  JadwalKhususModel({
    this.id,
    this.tanggal,
    this.jamMulai,
    this.jamSelesai,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  DateTime tanggal;
  String jamMulai;
  String jamSelesai;
  String keterangan;
  DateTime createdAt;
  DateTime updatedAt;

  factory JadwalKhususModel.fromJson(Map<String, dynamic> json) =>
      JadwalKhususModel(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        jamMulai: json["jamMulai"],
        jamSelesai: json["jamSelesai"],
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  String humanDate() {
    try {
      return unixTimeStampToDateTime(tanggal.millisecondsSinceEpoch);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "jamMulai": jamMulai,
        "jamSelesai": jamSelesai,
        "keterangan": keterangan,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
