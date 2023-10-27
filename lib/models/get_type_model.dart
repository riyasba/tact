// To parse this JSON data, do
//
//     final getTypeModel = getTypeModelFromJson(jsonString);

import 'dart:convert';

GetTypeModel getTypeModelFromJson(String str) => GetTypeModel.fromJson(json.decode(str));

String getTypeModelToJson(GetTypeModel data) => json.encode(data.toJson());

class GetTypeModel {
    List<Success> success;

    GetTypeModel({
        required this.success,
    });

    factory GetTypeModel.fromJson(Map<String, dynamic> json) => GetTypeModel(
        success: List<Success>.from(json["success"].map((x) => Success.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x.toJson())),
    };
}

class Success {
    int id;
    String title;
    String description;
    DateTime createdAt;
    DateTime updatedAt;

    Success({
        required this.id,
        required this.title,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
