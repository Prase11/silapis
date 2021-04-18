import 'dart:convert';

import 'package:silapis/utils/format_date.dart';

class BeritaListModel {
  List<BeritaModel> list;

  BeritaListModel(this.list);

  factory BeritaListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return BeritaModel.fromJson(item);
    }).toList();

    return BeritaListModel(list);
  }
}

BeritaModel beritaModelFromJson(String str) =>
    BeritaModel.fromJson(json.decode(str));

String beritaModelToJson(BeritaModel data) => json.encode(data.toJson());

class BeritaModel {
  BeritaModel({
    this.id,
    this.judul,
    this.tanggal,
    this.konten,
    this.gambar,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String judul;
  DateTime tanggal;
  String konten;
  String gambar;
  DateTime createdAt;
  DateTime updatedAt;

  factory BeritaModel.fromJson(Map<String, dynamic> json) => BeritaModel(
        id: json["id"],
        judul: json["judul"],
        tanggal: DateTime.parse(json["tanggal"]),
        konten: json["konten"],
        gambar: json["gambar"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "tanggal": tanggal.toIso8601String(),
        "konten": konten,
        "gambar": gambar,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  String humanDate() {
    try {
      return unixTimeStampToDateTime(tanggal.millisecondsSinceEpoch);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
