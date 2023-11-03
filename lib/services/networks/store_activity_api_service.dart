import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/services/base_url/base_url.dart';

class StoreActivityApiService extends BaseApiServices {
  Future storeactivityapi(
      {required String c_id,
      required String s_id,
      required String from_time,
      required String to_time,
      required String title}) async {
    dynamic responseJson;
    try {
      var formData = FormData.fromMap({
        "c_id": c_id,
        "s_id": s_id,
        "from_time": from_time,
        "to_time": to_time,
        "title": title,
      });
      var dio = Dio();
      var response = await dio.post(storeactivityURL,
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

      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
      print(
          "::::::::<--TACT  store activity   api-->::::::::status code:::::::::");
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
