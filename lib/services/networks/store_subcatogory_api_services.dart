import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/services/base_url/base_url.dart';

class StoreSubCatogoryApiService extends BaseApiServices {
  Future storesubcatogoryapi({
    required String title,
    required String description,
    required String categoryid,
  }) async {
    dynamic responseJson;

    try {
      var formData = FormData.fromMap({
        "title": title,
        "description": description,
        "category_id": categoryid,
      });
      var dio = Dio();
      var response = await dio.post(storesubcatogoryURL,
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
          "::::-------------------------------------------::::<--TACT store subcatogory log  api-->::::::::status code:::-------------------------------::::::");
      print(
          "::::-------------------------------------------::::<--TACT store subcatogory log  api-->::::::::status code:::-------------------------------::::::");
      print(
          "::::-------------------------------------------::::<--TACT store subcatogory log  api-->::::::::status code:::-------------------------------::::::");
      print(
          "::::-------------------------------------------::::<--TACT store subcatogory log  api-->::::::::status code:::-------------------------------::::::");
      print(
          "::::-------------------------------------------::::<--TACT store subcatogory log  api-->::::::::status code:::-------------------------------::::::");
      print(
          "::::-------------------------------------------::::<--TACT store subcatogory log  api-->::::::::status code:::-------------------------------::::::");
      print(
          "::::-------------------------------------------::::<--TACT store subcatogory log  api-->::::::::status code:::-------------------------------::::::");
      print(
          "::::-------------------------------------------::::<--TACT store subcatogory log  api-->::::::::status code:::-------------------------------::::::");
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
