// To parse this JSON data, do
//
//     final layananPengaduanModel = layananPengaduanModelFromJson(jsonString);

import 'dart:convert';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

LayananPengaduanModel layananPengaduanModelFromJson(String str) =>
    LayananPengaduanModel.fromJson(json.decode(str));

String layananPengaduanModelToJson(LayananPengaduanModel data) =>
    json.encode(data.toJson());

class LayananPengaduanListModel {
  List<LayananPengaduanModel> list;

  LayananPengaduanListModel(this.list);

  factory LayananPengaduanListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return LayananPengaduanModel.fromJson(item);
    }).toList();

    return LayananPengaduanListModel(list);
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class LayananPengaduanModel {
  LayananPengaduanModel({
    this.id,
    this.nama,
    this.link,
    this.icon,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String nama;
  String link;
  IconData icon;
  Color color;
  DateTime createdAt;
  DateTime updatedAt;

  factory LayananPengaduanModel.fromJson(Map<String, dynamic> json) =>
      LayananPengaduanModel(
        id: json["id"],
        nama: json["nama"],
        link: json["link"],
        icon: _getIconData(json["icon"] ?? ''),
        color: HexColor.fromHex(json["color"] ?? '#4caf50'),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "link": link,
        "icon": icon,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  static IconData _getIconData(String icon) {
    if (icon.contains('whatsapp')) {
      return FontAwesomeIcons.whatsapp;
    } else if (icon.contains('phone')) {
      return FontAwesomeIcons.phoneAlt;
    }
    return FontAwesomeIcons.fileAlt;
  }
}
