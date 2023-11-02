import 'package:flutter/material.dart';

import 'package:flutter_application_1/app/data/constands/constands.dart';

import 'package:flutter_application_1/models/get_activity_model.dart';
import 'package:flutter_application_1/models/get_catogory_model.dart';

import 'package:flutter_application_1/models/get_subcatogory_model.dart';



import 'package:flutter_application_1/services/networks/get_activity_api_service.dart';
import 'package:flutter_application_1/services/networks/get_catogory_api_services.dart';

import 'package:flutter_application_1/services/networks/get_getsubcatogory_api_services.dart';
import 'package:flutter_application_1/services/networks/store_activity_api_service.dart';
import 'package:flutter_application_1/services/networks/store_subcatogory_api_services.dart';

import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;

class TactApiController extends GetxController {
  GetSubCatogoriesApiServices gettypeapiservice = GetSubCatogoriesApiServices();




  List<Success> subcategorList0 = [];
  List<Success> subcategorList1 = [];
  List<Success> subcategorList2 = [];
  List<Success> subcategorList3 = [];
  List<Success> subcategorList4 = [];
  List<Success> subcategorList5 = [];
  List<Success> subcategorList6 = [];
  List<Success> subcategorList7 = [];
  List<Success> subcategorList8 = [];
  List<Success> subcategorList9 = [];




  getsubcatogory({required dynamic id}) async {
    dio.Response<dynamic> response =
        await gettypeapiservice.getsubcatogoriestype(id: id.toString());

    if (response.statusCode == 200) {
      GetSubCatogoryModel getvaluetypemodel =
          GetSubCatogoryModel.fromJson(response.data);
      if (id == 1) {
        subcategorList0 = getvaluetypemodel.data;
      } else if (id == 2) {
        subcategorList1 = getvaluetypemodel.data;
      } else if (id == 3) {
        subcategorList2 = getvaluetypemodel.data;
      } else if (id == 4) {
        subcategorList3 = getvaluetypemodel.data;
      } else if (id == 5) {
        subcategorList4 = getvaluetypemodel.data;
      } else if (id == 6) {
        subcategorList5 = getvaluetypemodel.data;
      } else if (id == 7) {
        subcategorList6 = getvaluetypemodel.data;
      } else if (id == 8) {
        subcategorList7 = getvaluetypemodel.data;
      } else if (id == 9) {
        subcategorList8 = getvaluetypemodel.data;
      }
      update();
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          "Something went wrong",
          style: TextStyle(fontSize: 15, color: kwhite),
        ),
      );
    }
    update();
  }

  List<Success> getDatList(int id) {
    List<Success> tempList = [];
    if (id == 1) {
      tempList = subcategorList0;
    } else if (id == 2) {
      tempList = subcategorList1;
    } else if (id == 3) {
      tempList = subcategorList2;
    } else if (id == 4) {
      tempList = subcategorList3;
    } else if (id == 5) {
      tempList = subcategorList4;
    } else if (id == 6) {
      tempList = subcategorList5;
    } else if (id == 7) {
      tempList = subcategorList6;
    } else if (id == 8) {
      tempList = subcategorList7;
    } else if (id == 9) {
      tempList = subcategorList8;
    }
    return tempList;
  }

  StoreActivityApiService activitylogapiservice = StoreActivityApiService();

  Future storeactivity(
      {required String catogory,
      required String c_id,
      required String s_id,
      required String from_time,
      required String to_time,
      required String title}) async {
    dio.Response<dynamic> response =
        await activitylogapiservice.storeactivityapi(
            catogory: catogory,
            c_id: c_id,
            s_id: s_id,
            from_time: from_time,
            to_time: to_time,
            title: title);
   
    update();
  }

  StoreSubCatogoryApiService stoetypeapiservice = StoreSubCatogoryApiService();
  Future storesubcatogory(
      {required String title,
      required String description,
      required dynamic categoryid}) async {
    dio.Response<dynamic> response =
        await stoetypeapiservice.storesubcatogoryapi(
            title: title, description: description, categoryid: categoryid);
// getcatogory( );

    if (response.statusCode == 200) {
      print('status code has sucess store type');
      getcatogory();
    }
  }

  GetCatogoryApiServices getcatogoryapiservices = GetCatogoryApiServices();

  List<CatogoryList> catogorylist = [];

  Future getcatogory() async {
    dio.Response<dynamic> response =
        await getcatogoryapiservices.getcatogoryapi();
    if (response.statusCode == 200) {
      GetCatogoryModel getCatogoryModel =
          GetCatogoryModel.fromJson(response.data);
      catogorylist = getCatogoryModel.dataLogs;
      update();

      for (var categ in catogorylist) {
        getsubcatogory(id: categ.id);
      }
      //storedatas(title: '', description: '', categoryid: id);
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          "Something went wrong",
          style: TextStyle(fontSize: 15, color: kwhite),
        ),
      );
    }
    update();
  }

  GetActivityApiService getactivityapiservice = GetActivityApiService();

  List<Activitylist> activitylist = [];
  Future getactivity() async {
    dio.Response<dynamic> response =
        await getactivityapiservice.getactivityapi();

    GetActivityModel getactivitymodel =
        GetActivityModel.fromJson(response.data);
    activitylist = getactivitymodel.data;
    update();
  }
}
