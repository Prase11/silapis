import 'dart:convert';

SettingModel settingModelFromJson(String str) =>
    SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

SettingListModel settinglFromJson(String str) =>
    SettingListModel.fromJson(json.decode(str));

class SettingListModel {
  List<SettingModel> list;

  SettingListModel(this.list);

  factory SettingListModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorList = json != null ? json['rows'] : [];

    final list = refactorList.map((item) {
      return SettingModel.fromJson(item);
    }).toList();

    return SettingListModel(list);
  }
}

class SettingModel {
  SettingModel({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory SettingModel.fromRawJson(String str) =>
      SettingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
