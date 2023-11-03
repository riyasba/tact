// To parse this JSON data, do
//
//     final getActivityModel = getActivityModelFromJson(jsonString);

import 'dart:convert';

GetActivityModel getActivityModelFromJson(String str) => GetActivityModel.fromJson(json.decode(str));

String getActivityModelToJson(GetActivityModel data) => json.encode(data.toJson());

class GetActivityModel {
    bool status;
    String message;
    String totalTime;
    String actualTime;
    List<Activitylist> data;

    GetActivityModel({
        required this.status,
        required this.message,
        required this.totalTime,
        required this.actualTime,
        required this.data,
    });

    factory GetActivityModel.fromJson(Map<String, dynamic> json) => GetActivityModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        totalTime: json["total_time"] ?? "",
        actualTime: json["actual_time"] ??"",
        data: List<Activitylist>.from(json["data"].map((x) => Activitylist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total_time": totalTime,
        "actual_time": actualTime,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Activitylist {
    int id;
    String title;
    String categoryId;
    String subCategory;
    String fromTime;
    String toTime;
    DateTime createdAt;
    DateTime updatedAt;
    String categoryTitle;
    String subTitle;

    Activitylist({
        required this.id,
        required this.title,
        required this.categoryId,
        required this.subCategory,
        required this.fromTime,
        required this.toTime,
        required this.createdAt,
        required this.updatedAt,
        required this.categoryTitle,
        required this.subTitle,
    });

    factory Activitylist.fromJson(Map<String, dynamic> json) => Activitylist(
        id: json["id"],
        title: json["title"],
        categoryId: json["category_id"],
        subCategory: json["sub_category"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryTitle: json["categoryTitle"],
        subTitle: json["subTitle"]??"",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category_id": categoryId,
        "sub_category": subCategory,
        "from_time": fromTime,
        "to_time": toTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "categoryTitle": categoryTitle,
        "subTitle": subTitle,
    };
}
