// To parse this JSON data, do
//
//     final getSubCatogoryModel = getSubCatogoryModelFromJson(jsonString);

import 'dart:convert';

GetSubCatogoryModel getSubCatogoryModelFromJson(String str) => GetSubCatogoryModel.fromJson(json.decode(str));

String getSubCatogoryModelToJson(GetSubCatogoryModel data) => json.encode(data.toJson());

class GetSubCatogoryModel {
    bool status;
    String message;
    List<Success> data;

    GetSubCatogoryModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetSubCatogoryModel.fromJson(Map<String, dynamic> json) => GetSubCatogoryModel(
        status: json["status"],
        message: json["message"],
        data: List<Success>.from(json["data"].map((x) => Success.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Success {
    int id;
    String categoryId;
    String subTitle;
    String description;
    DateTime createdAt;
    DateTime updatedAt;

    Success({
        required this.id,
        required this.categoryId,
        required this.subTitle,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
        categoryId: json["category_id"],
        subTitle: json["sub_title"],
        description: json["description"]??"",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "sub_title": subTitle,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
