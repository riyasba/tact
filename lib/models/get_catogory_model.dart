

import 'dart:convert';

GetCatogoryModel getCatogoryModelFromJson(String str) => GetCatogoryModel.fromJson(json.decode(str));

String getCatogoryModelToJson(GetCatogoryModel data) => json.encode(data.toJson());

class GetCatogoryModel {
    bool status;
    List<CatogoryList> dataLogs;

    GetCatogoryModel({
        required this.status,
        required this.dataLogs,
    });

    factory GetCatogoryModel.fromJson(Map<String, dynamic> json) => GetCatogoryModel(
        status: json["status"],
        dataLogs: List<CatogoryList>.from(json["data logs"].map((x) => CatogoryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data logs": List<dynamic>.from(dataLogs.map((x) => x.toJson())),
    };
}

class CatogoryList {
    int id;
    String title;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    int index;

    CatogoryList({
      required this.index,
        required this.id,
        required this.title,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CatogoryList.fromJson(Map<String, dynamic> json) => CatogoryList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]), index: 0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
