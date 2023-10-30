// To parse this JSON data, do
//
//     final getActivityLogModel = getActivityLogModelFromJson(jsonString);

import 'dart:convert';

GetActivityLogModel getActivityLogModelFromJson(String str) => GetActivityLogModel.fromJson(json.decode(str));

String getActivityLogModelToJson(GetActivityLogModel data) => json.encode(data.toJson());

class GetActivityLogModel {
    String getActivityLogModelCase;
    List<List<ActivityLog>> activityLogs;
    String startTime;
    String endTime;

    GetActivityLogModel({
        required this.getActivityLogModelCase,
        required this.activityLogs,
        required this.startTime,
        required this.endTime,
    });

    factory GetActivityLogModel.fromJson(Map<String, dynamic> json) => GetActivityLogModel(
        getActivityLogModelCase: json["case"],
        activityLogs: List<List<ActivityLog>>.from(json["Activity logs"].map((x) => List<ActivityLog>.from(x.map((x) => ActivityLog.fromJson(x))))),
        startTime: json["start_time"],
        endTime: json["end_time"],
    );

    Map<String, dynamic> toJson() => {
        "case": getActivityLogModelCase,
        "Activity logs": List<dynamic>.from(activityLogs.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "start_time": startTime,
        "end_time": endTime,
    };
}

class ActivityLog {
    String category;
    String? typeOfCategory;

    ActivityLog({
        required this.category,
        required this.typeOfCategory,
    });

    factory ActivityLog.fromJson(Map<String, dynamic> json) => ActivityLog(
        category: json["Category"],
        typeOfCategory: json["Type of Category"],
    );

    Map<String, dynamic> toJson() => {
        "Category": category,
        "Type of Category": typeOfCategory,
    };
}
