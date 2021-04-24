import 'dart:convert';

FotoBerandaModel fotoBerandaModelFromJson(String str) =>
    FotoBerandaModel.fromJson(json.decode(str));

String fotoBerandaModelToJson(FotoBerandaModel data) =>
    json.encode(data.toJson());

FotoBerandaListModel fotoBerandalFromJson(String str) =>
    FotoBerandaListModel.fromJson(json.decode(str));

class FotoBerandaListModel {
  List<FotoBerandaModel> list;

  FotoBerandaListModel(this.list);

  factory FotoBerandaListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return FotoBerandaModel.fromJson(item);
    }).toList();

    return FotoBerandaListModel(list);
  }
}

class FotoBerandaModel {
  FotoBerandaModel({
    this.id,
    this.foto,
    this.isActive,
  });

  String id;
  String foto;
  String isActive;

  factory FotoBerandaModel.fromRawJson(String str) =>
      FotoBerandaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FotoBerandaModel.fromJson(Map<String, dynamic> json) =>
      FotoBerandaModel(
        id: json["id"],
        foto: json["foto"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "foto": foto,
        "isActive": isActive,
      };
}
