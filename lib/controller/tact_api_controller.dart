import 'package:flutter/material.dart';

import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:flutter_application_1/models/get_activity_log.dart';

import 'package:flutter_application_1/models/get_type_model.dart';
import 'package:flutter_application_1/services/base_url/base_url.dart';
import 'package:flutter_application_1/services/networks/activity_log_api_service.dart';

import 'package:flutter_application_1/services/networks/get_type_api_services.dart';
import 'package:flutter_application_1/services/networks/store_type_api_services.dart';

import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;

class TactApiController extends GetxController {
  GetTypesApiServices gettypeapiservice = GetTypesApiServices();

  List<Success> gettypelistdata = [];

  gettype({required String typevalue}) async {
    dio.Response<dynamic> response =
        await gettypeapiservice.getvaluetype(typevalue: typevalue);

    if (response.statusCode == 200) {
      GetTypeModel getvaluetypemodel = GetTypeModel.fromJson(response.data);
      gettypelistdata = getvaluetypemodel.success;
    } else {
      Get.rawSnackbar(
          backgroundColor: Colors.red,
          messageText: Text("Something went wrong",
              style: TextStyle(fontSize: 15, color: kwhite)));
    }
    update();
  }

  ActivityLogApiService activitylogapiservice = ActivityLogApiService();
  List<List<ActivityLog>> activityloglistdata = [];

  Future activitylog(
      {required String endtime,
      required String starttime,
      required String type,
      required String catogory}) async {
    dio.Response<dynamic> response = await activitylogapiservice.activitlog(
      type: type,
      catogory: catogory,
      starttime: starttime,
      endtime: endtime,
    );
    if (response.statusCode == 200) {
      GetActivityLogModel getactivitymodel =
          GetActivityLogModel.fromJson(response.data);
      activityloglistdata = getactivitymodel.activityLogs;
    } else {
      Get.rawSnackbar(
          backgroundColor: Colors.red,
          messageText: Text("Something went wrong",
              style: TextStyle(fontSize: 15, color: kwhite)));
    }
    update();
  }

  StoreTypeApiService stoetypeapiservice = StoreTypeApiService();
  Future storedatas(
      {required String title,
      required String description,
      required String type}) async {
    dio.Response<dynamic> response = await stoetypeapiservice.storetype(
        title: title, description: description, type: type);
    // if (response.statusCode == 200) {}
  }
}
