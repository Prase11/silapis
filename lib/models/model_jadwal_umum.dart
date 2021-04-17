// To parse this JSON data, do
//
//     final jadwalUmumModel = jadwalUmumModelFromJson(jsonString);

import 'dart:convert';

JadwalUmumModel jadwalUmumModelFromJson(String str) =>
    JadwalUmumModel.fromJson(json.decode(str));

String jadwalUmumModelToJson(JadwalUmumModel data) =>
    json.encode(data.toJson());

class JadwalUmumListModel {
  List<JadwalUmumModel> list;

  JadwalUmumListModel(this.list);

  factory JadwalUmumListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return JadwalUmumModel.fromJson(item);
    }).toList();

    return JadwalUmumListModel(list);
  }
}

class JadwalUmumModel {
  JadwalUmumModel({
    this.id,
    this.hari,
    this.jamMulai,
    this.jamSelesai,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String hari;
  String jamMulai;
  String jamSelesai;
  DateTime createdAt;
  DateTime updatedAt;

  factory JadwalUmumModel.fromJson(Map<String, dynamic> json) =>
      JadwalUmumModel(
        id: json["id"],
        hari: json["hari"],
        jamMulai: json["jamMulai"],
        jamSelesai: json["jamSelesai"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hari": hari,
        "jamMulai": jamMulai,
        "jamSelesai": jamSelesai,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
