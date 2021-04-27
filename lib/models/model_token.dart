// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

import 'package:silapis/utils/api/jwt_decode.dart';

class TokenModel {
  TokenModel({
    this.iss,
    this.aud,
    this.iat,
    this.nbf,
    this.exp,
    this.user,
    this.key,
  });

  String iss;
  String aud;
  int iat;
  int nbf;
  int exp;
  User user;
  String key;

  factory TokenModel.fromRawJson(String str) =>
      TokenModel.fromJson(json.decode(str));

  factory TokenModel.formJwt(String str) => TokenModel.fromJson(parseJwt(str));

  String toRawJson() => json.encode(toJson());

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        iss: json["iss"],
        aud: json["aud"],
        iat: json["iat"],
        nbf: json["nbf"],
        exp: json["exp"],
        user: User.fromJson(json["user"]),
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "iss": iss,
        "aud": aud,
        "iat": iat,
        "nbf": nbf,
        "exp": exp,
        "user": user.toJson(),
        "key": key,
      };
}

class User {
  User({
    this.role,
    this.username,
    this.password,
    this.nama,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Role role;
  String username;
  String password;
  String nama;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        role: Role.fromJson(json["role"]),
        username: json["username"],
        password: json["password"],
        nama: json["nama"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "role": role.toJson(),
        "username": username,
        "password": password,
        "nama": nama,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class Role {
  Role({
    this.username,
    this.aplikasi,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String username;
  String aplikasi;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        username: json["username"],
        aplikasi: json["aplikasi"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "aplikasi": aplikasi,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
