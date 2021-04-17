// To parse this JSON data, do
//
//     final pegawaiModel = pegawaiModelFromJson(jsonString);

import 'dart:convert';

PegawaiModel pegawaiModelFromJson(String str) =>
    PegawaiModel.fromJson(json.decode(str));

String pegawaiModelToJson(PegawaiModel data) => json.encode(data.toJson());

class PegawaiListModel {
  List<PegawaiModel> list;

  PegawaiListModel(this.list);

  factory PegawaiListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return PegawaiModel.fromJson(item);
    }).toList();

    return PegawaiListModel(list);
  }
}

class PegawaiModel {
  PegawaiModel({
    this.nip,
    this.nik,
    this.nama,
    this.status,
    this.jk,
    this.foto,
    this.createdAt,
    this.updatedAt,
  });

  String nip;
  String nik;
  String nama;
  String status;
  String jk;
  String foto;
  DateTime createdAt;
  DateTime updatedAt;

  factory PegawaiModel.fromJson(Map<String, dynamic> json) => PegawaiModel(
        nip: json["nip"],
        nik: json["nik"],
        nama: json["nama"],
        jk: json["jk"] == 'L' ? 'Laki-Laki' : 'Perempuan',
        status: json["status"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "nip": nip,
        "nik": nik,
        "nama": nama,
        "status": status,
        "jk": jk,
        "foto": foto,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
