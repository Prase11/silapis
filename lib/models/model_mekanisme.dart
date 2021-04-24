import 'dart:convert';

MekanismeModel mekanismeModelFromJson(String str) =>
    MekanismeModel.fromJson(json.decode(str));

String mekanismeModelToJson(MekanismeModel data) => json.encode(data.toJson());

MekanismeListModel mekanismelFromJson(String str) =>
    MekanismeListModel.fromJson(json.decode(str));

class MekanismeListModel {
  List<MekanismeModel> list;

  MekanismeListModel(this.list);

  factory MekanismeListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return MekanismeModel.fromJson(item);
    }).toList();

    return MekanismeListModel(list);
  }
}

class MekanismeModel {
  MekanismeModel({
    this.id,
    this.kode,
    this.nama,
    this.foto,
  });

  String id;
  String kode;
  String nama;
  String foto;

  factory MekanismeModel.fromRawJson(String str) =>
      MekanismeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MekanismeModel.fromJson(Map<String, dynamic> json) => MekanismeModel(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama": nama,
        "foto": foto,
      };
}