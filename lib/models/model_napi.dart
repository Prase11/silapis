// To parse this JSON data, do
//
//     final napiModel = napiModelFromJson(jsonString);

import 'dart:convert';

class NapiListModel {
  List<NapiModel> list;

  NapiListModel(this.list);

  factory NapiListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return NapiModel.fromJson(item);
    }).toList();

    return NapiListModel(list);
  }
}

class NapiModel {
  NapiModel({
    this.id,
    this.noReg,
    this.nama,
    this.blokKamar,
    this.uu,
    this.lamaPidanaBulan,
    this.lamaPidanaTahun,
    this.jnsKejahatan,
    this.tanggalEkspirasi,
    this.uptAsal,
    this.pasalUtama,
    this.jenisKejahatanNarkotika,
    this.statusKerjaWali,
    this.pasFoto,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String noReg;
  String nama;
  String blokKamar;
  String uu;
  String lamaPidanaBulan;
  String lamaPidanaTahun;
  String jnsKejahatan;
  DateTime tanggalEkspirasi;
  String uptAsal;
  String pasalUtama;
  String jenisKejahatanNarkotika;
  String statusKerjaWali;
  String pasFoto;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory NapiModel.fromRawJson(String str) =>
      NapiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NapiModel.fromJson(Map<String, dynamic> json) => NapiModel(
        id: json["id"].toString(),
        noReg: json["noReg"],
        nama: json["nama"],
        blokKamar: json["blokKamar"],
        uu: json["uu"],
        lamaPidanaBulan: json["lamaPidanaBulan"].toString(),
        lamaPidanaTahun: json["lamaPidanaTahun"].toString(),
        jnsKejahatan: json["jnsKejahatan"],
        tanggalEkspirasi: json["tanggalEkspirasi"] != null
            ? DateTime.parse(json["tanggalEkspirasi"])
            : DateTime.now(),
        uptAsal: json["uptAsal"],
        pasalUtama: json["pasalUtama"],
        jenisKejahatanNarkotika: json["jenisKejahatanNarkotika"],
        statusKerjaWali: json["statusKerjaWali"],
        pasFoto: json["pasFoto"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "noReg": noReg,
        "nama": nama,
        "blokKamar": blokKamar,
        "uu": uu,
        "lamaPidanaBulan": lamaPidanaBulan,
        "lamaPidanaTahun": lamaPidanaTahun,
        "jnsKejahatan": jnsKejahatan,
        "tanggalEkspirasi": tanggalEkspirasi.toIso8601String(),
        "uptAsal": uptAsal,
        "pasalUtama": pasalUtama,
        "jenisKejahatanNarkotika": jenisKejahatanNarkotika,
        "statusKerjaWali": statusKerjaWali,
        "pasFoto": pasFoto,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
