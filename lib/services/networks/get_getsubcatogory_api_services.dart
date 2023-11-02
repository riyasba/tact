import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/services/base_url/base_url.dart';

class GetSubCatogoriesApiServices extends BaseApiServices {

  Future getsubcatogoriestype({required String id}) async {
    dynamic responseJson;
    try {
      var formData = FormData.fromMap({
        "c_id": id,
      });
      var dio = Dio();
      var response = await dio.post(getsubcategoryURL,
          options: Options(
              headers: {
                'Accept': 'application/json',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: formData
          );

      responseJson = response;

      print("::::::::<--TACT get SUB CATOGORY api-->::::::::status code:::::::::");

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
