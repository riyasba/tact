import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/services/base_url/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteActivityApiServices extends BaseApiServices {

  Future deleteactivityapi({required String appid}) async { 

    dynamic responseJson;

    try {
      final prefs = await SharedPreferences.getInstance();
      String? appId = prefs.getString("auth_token");

   var formData = FormData.fromMap({
       "app_id":appId
      });


      var dio = Dio();
      var response = await dio.post(
        deleteactivityURL,
        options: Options(
           headers: {
               'Content-Type': 'application/json'
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
    data: formData   );     
      responseJson = response;


      print(
          "::::::::<<<<<- delete  activity  api-->>>>>::::::::status code:::::::::");



    } on SocketException {
      print('no internet');
    }
    return responseJson;
  }

  dynamic returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        print("here.>>>>>>>>>>>>");
        return responseJson;
      case 400:
      // throw BadRequestException(response.body.toString());
      case 401:
      case 403:
      // throw UnauthorisedException(response.body.toString());
      case 404:
      // throw UnauthorisedException(response.body.toString());
      case 500:
      default:
      // throw FetchDataException(
      //     'Error occured while communication with server' +
      //         ' with status code : ${response.statusCode}');
    }
  }
}
