import 'package:flutter/material.dart';

import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:flutter_application_1/models/get_activity_log.dart';

import 'package:flutter_application_1/models/get_type_model.dart';
import 'package:flutter_application_1/services/base_url/base_url.dart';

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

  StoreTypeApiService storetypeapiservice = StoreTypeApiService();
  List<List<ActivityLog>> activityloglistdata = [];

  Future activitylog(
      {required String description,
      required String title,
      required String type}) async {
    dio.Response<dynamic> response = await storetypeapiservice.storetype(
      description: description,
      title: title,
      type: type,
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
}
