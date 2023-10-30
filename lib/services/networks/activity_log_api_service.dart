import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/services/base_url/base_url.dart';

class ActivityLogApiService extends BaseApiServices {
  Future activitlog({
    required String catogory,
    required String type,
    required String starttime,
    required String endtime,
  }) async {
    dynamic responseJson;
    try {
      var formData = FormData.fromMap({
        "category[]": catogory,
        "type[]": type,
        "start_time": starttime,
        "end_time": endtime,
      });
      var dio = Dio();
      var response = await dio.post(activitylogURL,
          options: Options(
              headers: {
                'Accept': 'application/json',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: formData);

      responseJson = response;

      print("::::::::<--TACT activity log  api-->::::::::status code:::::::::");
      print(response.data);
    } on SocketException {
      print("no internet");
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
