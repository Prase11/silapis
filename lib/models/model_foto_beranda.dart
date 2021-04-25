import 'dart:convert';
import 'package:silapis/configs/config.dart';

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

  factory FotoBerandaListModel.fromRawJson(String str) =>
      FotoBerandaListModel.fromJson({'rows': json.decode(str)});

  @override
  String toString() {
    return json.encode(list.map((e) => e.toJson()).toList());
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

  String getImage() {
    return '${Environment.apiUrl}/file/foto_beranda/$foto';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "foto": foto,
        "isActive": isActive,
      };
}
