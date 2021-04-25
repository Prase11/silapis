import 'dart:convert';

SosmedModel sosmedModelFromJson(String str) =>
    SosmedModel.fromJson(json.decode(str));

String sosmedModelToJson(SosmedModel data) => json.encode(data.toJson());

SosmedListModel sosmedlFromJson(String str) =>
    SosmedListModel.fromJson(json.decode(str));

class SosmedListModel {
  List<SosmedModel> list;

  SosmedListModel(this.list);

  factory SosmedListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return SosmedModel.fromJson(item);
    }).toList();

    return SosmedListModel(list);
  }

  factory SosmedListModel.fromRawJson(String str) =>
      SosmedListModel.fromJson({'rows': json.decode(str)});

  @override
  String toString() {
    return json.encode(list.map((e) => e.toJson()).toList());
  }
}

class SosmedModel {
  SosmedModel({
    this.id,
    this.nama,
    this.link,
    this.warna,
    this.icon,
    this.keterangan,
  });

  String id;
  String nama;
  String link;
  String warna;
  String icon;
  String keterangan;

  factory SosmedModel.fromRawJson(String str) =>
      SosmedModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SosmedModel.fromJson(Map<String, dynamic> json) => SosmedModel(
        id: json["id"],
        nama: json["nama"],
        link: json["link"],
        warna: json["warna"],
        icon: json["icon"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "link": link,
        "warna": warna,
        "icon": icon,
        "keterangan": keterangan,
      };
}
