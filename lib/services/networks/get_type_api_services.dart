import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/services/base_url/base_url.dart';


class GetTypesApiServices extends BaseApiServices {
  Future getvaluetype() async {
    dynamic responseJson;
    try {
      var dio = Dio();
      var response=await dio.get(gettype,
      options: Options(headers: {}));
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
