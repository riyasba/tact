import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:flutter_application_1/models/get_activity_model.dart';
import 'package:flutter_application_1/models/get_catogory_model.dart';
import 'package:flutter_application_1/models/get_subcatogory_model.dart';
import 'package:flutter_application_1/models/store_activity_list_model.dart';
import 'package:flutter_application_1/services/networks/delete_activity_api_service.dart';
import 'package:flutter_application_1/services/networks/delete_subcatogory_apisercvice.dart';
import 'package:flutter_application_1/services/networks/get_activity_api_service.dart';
import 'package:flutter_application_1/services/networks/get_catogory_api_services.dart';
import 'package:flutter_application_1/services/networks/get_getsubcatogory_api_services.dart';
import 'package:flutter_application_1/services/networks/store_activity_api_service.dart';
import 'package:flutter_application_1/services/networks/store_subcatogory_api_services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class TactApiController extends GetxController {
  GetSubCatogoriesApiServices gettypeapiservice = GetSubCatogoriesApiServices();

  RxBool isLoading = false.obs;
  RxBool isButtonLoading = false.obs;

  List<StoreActivityListModel> selectedSubCatIdList = [];

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

  String? selectedValue0;
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  String? selectedValue4;
  String? selectedValue5;
  String? selectedValue6;
  String? selectedValue7;
  String? selectedValue8;
  String? selectedValue9;
  String? selectedValue10;

  RxString overallCprTime = "00:00:00".obs;
  RxString actualTimetotal = "00:00:00".obs;

  getsubcatogory({required dynamic id}) async {
    dio.Response<dynamic> response =
        await gettypeapiservice.getsubcatogoriestype(id: id.toString());

    if (response.statusCode == 200) {
      GetSubCatogoryModel getvaluetypemodel =
          GetSubCatogoryModel.fromJson(response.data);
      List<Success> tempSubcategorList = [];
      if (id == 1) {
        tempSubcategorList = subcategorList0;
        subcategorList0 = getvaluetypemodel.data;
       
      } else if (id == 2) {
         tempSubcategorList = subcategorList1;
        subcategorList1 = getvaluetypemodel.data;
     
      } else if (id == 3) {
         tempSubcategorList = subcategorList2;
        subcategorList2 = getvaluetypemodel.data;
       
      } else if (id == 4) {
         tempSubcategorList = subcategorList3;
        subcategorList3 = getvaluetypemodel.data;
       
      } else if (id == 5) {
         tempSubcategorList = subcategorList4;
        subcategorList4 = getvaluetypemodel.data;
      
      } else if (id == 6) {
         tempSubcategorList = subcategorList5;
        subcategorList5 = getvaluetypemodel.data;
        
      } else if (id == 7) {
         tempSubcategorList = subcategorList6;
        subcategorList6 = getvaluetypemodel.data;
       
      } else if (id == 8) {
         tempSubcategorList = subcategorList7;
        subcategorList7 = getvaluetypemodel.data;
      
      } else if (id == 9) {
        tempSubcategorList = subcategorList8;
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




  getsubcatogoryForSubCategory({required dynamic id,required int subId}) async {
    dio.Response<dynamic> response =
        await gettypeapiservice.getsubcatogoriestype(id: id.toString());

    if (response.statusCode == 200) {
      GetSubCatogoryModel getvaluetypemodel =
          GetSubCatogoryModel.fromJson(response.data);
      List<Success> tempSubcategorList = [];
      if (id == 1) {
        tempSubcategorList = subcategorList0;
        subcategorList0 = getvaluetypemodel.data;

        tempSubcategorList.forEach((element) {
        
          if(element.isSelected){

            for (var i = 0; i < subcategorList0.length; i++) {

              if(subcategorList0[i].id == element.id){
                subcategorList0[i].isSelected = true;
              }

              
            }

          }
            
          
        });

           for (var i = 0; i < subcategorList0.length; i++) {
               if(subcategorList0[i].id == subId){
                subcategorList0[i].isSelected = true;
              }
             
            }

      } else if (id == 2) {
         tempSubcategorList = subcategorList1;
        subcategorList1 = getvaluetypemodel.data;
        tempSubcategorList.forEach((element) {
        
          if(element.isSelected){

            for (var i = 0; i < subcategorList1.length; i++) {

              if(subcategorList1[i].id == element.id){
                subcategorList1[i].isSelected = true;
              }
              
            }

          }
            
          
        });
         for (var i = 0; i < subcategorList1.length; i++) {

              
               if(subcategorList1[i].id == subId){
                subcategorList1[i].isSelected = true;
              }
            }
      } else if (id == 3) {
         tempSubcategorList = subcategorList2;
        subcategorList2 = getvaluetypemodel.data;
        tempSubcategorList.forEach((element) {
        
          if(element.isSelected){

            for (var i = 0; i < subcategorList0.length; i++) {

              if(subcategorList2[i].id == element.id){
                subcategorList2[i].isSelected = true;
              }

              
             
            }

          }
            
          
        });

        for (var i = 0; i < subcategorList0.length; i++) {

           
                if(subcategorList2[i].id == subId){
                subcategorList2[i].isSelected = true;
              }
             
            }
      } else if (id == 4) {
         tempSubcategorList = subcategorList3;
        subcategorList3 = getvaluetypemodel.data;
        tempSubcategorList.forEach((element) {
        
          if(element.isSelected){

            for (var i = 0; i < subcategorList3.length; i++) {

              if(subcategorList3[i].id == element.id){
                subcategorList3[i].isSelected = true;
              }

            }

          }
            
          
        });

        for (var i = 0; i < subcategorList3.length; i++) {
              if(subcategorList3[i].id == subId){
                subcategorList3[i].isSelected = true;
              }
        }
      } else if (id == 5) {
         tempSubcategorList = subcategorList4;
        subcategorList4 = getvaluetypemodel.data;
        tempSubcategorList.forEach((element) {
        
          if(element.isSelected){

            for (var i = 0; i < subcategorList4.length; i++) {

              if(subcategorList4[i].id == element.id){
                subcategorList4[i].isSelected = true;
              }


               
             
            }

          }
            
          
        });
        for (var i = 0; i < subcategorList4.length; i++) {

             

                if(subcategorList4[i].id == subId){
                subcategorList4[i].isSelected = true;
              }
             
            }
      } else if (id == 6) {
         tempSubcategorList = subcategorList5;
        subcategorList5 = getvaluetypemodel.data;
        tempSubcategorList.forEach((element) {
        
          if(element.isSelected){

            for (var i = 0; i < subcategorList5.length; i++) {
              if(subcategorList5[i].id == element.id){
                subcategorList5[i].isSelected = true;
              }

              
             
            }

          }
            
          
        });

         for (var i = 0; i < subcategorList5.length; i++) {
             

                if(subcategorList5[i].id == subId){
                subcategorList5[i].isSelected = true;
              }
             
            }
      } else if (id == 7) {
         tempSubcategorList = subcategorList6;
        subcategorList6 = getvaluetypemodel.data;
        tempSubcategorList.forEach((element) {
        
          if(element.isSelected){

            for (var i = 0; i < subcategorList6.length; i++) {

              if(subcategorList6[i].id == element.id){
                subcategorList6[i].isSelected = true;
              }
              
            }

          }
            
          
        });

         for (var i = 0; i < subcategorList6.length; i++) {

              
               if(subcategorList6[i].id == subId){
                subcategorList6[i].isSelected = true;
              }
            }
      } else if (id == 8) {
         tempSubcategorList = subcategorList7;
        subcategorList7 = getvaluetypemodel.data;
        tempSubcategorList.forEach((element) {
        
          if(element.isSelected){

            for (var i = 0; i < subcategorList7.length; i++) {

              if(subcategorList7[i].id == element.id){
                subcategorList7[i].isSelected = true;
              }
           
            }

          }
            
          
        });
        for (var i = 0; i < subcategorList7.length; i++) {

              
               if(subcategorList7[i].id == subId){
                subcategorList7[i].isSelected = true;
              }
            }
      } else if (id == 9) {
        tempSubcategorList = subcategorList8;
        subcategorList8 = getvaluetypemodel.data;
        tempSubcategorList.forEach((element) {
        
          if(element.isSelected){

            for (var i = 0; i < subcategorList8.length; i++) {

              if(subcategorList8[i].id == element.id){
                subcategorList8[i].isSelected = true;
              }
             
            }

          }
            
          
        });

        for (var i = 0; i < subcategorList8.length; i++) {

             
               if(subcategorList8[i].id == subId){
                subcategorList8[i].isSelected = true;
              }
            }
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

  deviceinfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print(
        'Running on ${androidInfo.id}-------------------------------build id---------------------------------------');
    return androidInfo.id;
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

  String? getGroupValue(int id) {
    if (id == 1) {
      return selectedValue0;
    } else if (id == 2) {
      return selectedValue1;
    } else if (id == 3) {
      return selectedValue2;
    } else if (id == 4) {
      return selectedValue3;
    } else if (id == 5) {
      return selectedValue4;
    } else if (id == 6) {
      return selectedValue5;
    } else if (id == 7) {
      return selectedValue6;
    } else if (id == 8) {
      return selectedValue7;
    } else if (id == 9) {
      return selectedValue8;
    } else {
      return selectedValue0;
    }
  }

  addGroupValue(int id, String value) {
    if (id == 1) {
      // if(already value assigned){
      //need to null
      // }else{
      //assign value
      // }
      selectedValue0 = value;
    } else if (id == 2) {
      selectedValue1 = value;
    } else if (id == 3) {
      selectedValue2 = value;
    } else if (id == 4) {
      selectedValue3 = value;
    } else if (id == 5) {
      selectedValue4 = value;
    } else if (id == 6) {
      selectedValue5 = value;
    } else if (id == 7) {
      selectedValue6 = value;
    } else if (id == 8) {
      selectedValue7 = value;
    } else if (id == 9) {
      selectedValue8 = value;
    } else {
      selectedValue0 = value;
    }
    update();
  }

  setDefaultGroupValue() {
    selectedValue0 = null;

    selectedValue1 = null;

    selectedValue2 = null;

    selectedValue3 = null;

    selectedValue4 = null;

    selectedValue5 = null;

    selectedValue6 = null;

    selectedValue7 = null;

    selectedValue8 = null;

    selectedValue0 = null;

    update();
  }

  int timeToSeconds(String time) {
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return (hours * 3600) + (minutes * 60) + seconds;
  }

  int getEfficiency({required String actualTime, required String overallTime}) {
    // Convert the time strings to seconds
    int seconds1 = timeToSeconds(actualTime);
    int seconds2 = timeToSeconds(overallTime);

    // Perform the division
    double result = seconds1 / seconds2;

    double finalResult = result * 100;

    print(finalResult.round());


     if (finalResult >= 0 && finalResult <= 59) {
      Text('You have achieved 50% of efficiency. Poor');
    } else if (finalResult >= 60 && finalResult <= 79) {
      Text('Congratulations you have achieved 85% of efficiency. Better');
    } else if (finalResult >= 80 && finalResult <= 89) {
      Text('Congratulations you have achieved 85% of efficiency. Good');
    } else if (finalResult >= 90 && finalResult <= 95) {
      Text('Congratulations you have achieved 85% of efficiency. Excellent');
    } else if (finalResult >= 96 && finalResult <= 100) {
      Text('Congratulations you have achieved 85% of efficiency. Outstanding');
    } else {
      Text('Efficiency out of range');
    }
  

    return finalResult.round();
    
  }

 
   

  StoreActivityApiService activitylogapiservice = StoreActivityApiService();

  storeactivity(
      {required String c_id,
      required String s_id,
      required String from_time,
      required String to_time,
      required String value,
      required String title,
      required String appid}) async {
    dio.Response<dynamic> response =
        await activitylogapiservice.storeactivityapi(
            c_id: c_id,
            s_id: s_id,
            from_time: from_time,
            to_time: to_time,
            title: title,
            value: value,
            appid: appid);
    // Get.snackbar(
    //   response.statusCode.toString(),
    //     response.data.toString(),
    //     backgroundColor: Colors.red,
    //     snackPosition: SnackPosition.BOTTOM
    // );

    getactivity(appid: '21346');
    update();
  }

  StoreSubCatogoryApiService stoetypeapiservice = StoreSubCatogoryApiService();
  Future<int> storesubcatogory(
      {required String title,
      required String description,
      required dynamic categoryid}) async {
    dio.Response<dynamic> response =
        await stoetypeapiservice.storesubcatogoryapi(
            title: title, description: description, categoryid: categoryid);
// getcatogory( );

    print(response.data);

    if (response.statusCode == 200) {
      print('status code has sucess store type');
      getsubcatogoryForSubCategory(id: int.parse(categoryid),subId:response.data["data"]["id"]);
    }
    return response.data["data"]["id"];
  }

  GetCatogoryApiServices getcatogoryapiservices = GetCatogoryApiServices();

  List<CatogoryList> catogorylist = [];

  Future getcatogory() async {
    isLoading(true);
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
      isLoading(false);
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

  List<ActivityCycleList> activitylist = [];
  List<ActivityCycleList> activitylistCurrent = [];
  var actualtime = '00:00:00';
  var endingtime = '00:00:00';
  getactivity({required String appid}) async {
   
    isLoading(true);
    activitylist.clear();
    dio.Response<dynamic> response =
        await getactivityapiservice.getactivityapi(appid: appid);
    isLoading(false);
     
    if (response.statusCode == 200) {
      GetActivityModel getactivitymodel =
          GetActivityModel.fromJson(response.data);
      List<Activitylist> tempActivityList = [];
      List<String> tempCycleList = [];

      // tempActivityList = getactivitymodel.data;
      getactivitymodel.data.forEach((element) {
        if (tempCycleList.contains(element.title) == false) {
          tempCycleList.add(element.title);
        }
      });
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print(tempCycleList.length);

      activitylist.clear();
      for (var i = 0; i < tempCycleList.length; i++) {
        print(
            '------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>****************************************************************************************************************************');

        List<Activitylist> tempList = [];
        for (var j = 0; j < getactivitymodel.data.length; j++) {
          if (tempCycleList[i] == getactivitymodel.data[j].title) {
            tempList.add(getactivitymodel.data[j]);
          }
        }
        ActivityCycleList activityCycleList = ActivityCycleList(
            activityList: tempList,
            cycleName: tempCycleList[i],
            cycleTime: tempList.first.toTime);
        activitylist.add(activityCycleList);
      }
      activitylistCurrent.clear();
      update();
    }
    // actualtime = getactivitymodel.actualTime;
    // endingtime = getactivitymodel.totalTime;
    update();
  }

  getactivityonStart({required String appid}) async {
    activitylist.clear();
    isLoading(true);
    dio.Response<dynamic> response =
        await getactivityapiservice.getactivityapi(appid: appid);
    isLoading(false);
    if (response.statusCode == 200) {
      GetActivityModel getactivitymodel =
          GetActivityModel.fromJson(response.data);
      List<Activitylist> tempActivityList = [];
      List<String> tempCycleList = [];

      // tempActivityList = getactivitymodel.data;
      getactivitymodel.data.forEach((element) {
        if (tempCycleList.contains(element.title) == false) {
          tempCycleList.add(element.title);
        }
      });
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print("----------------------------->>>>>>>>");
      print(tempCycleList.length);

      activitylist.clear();
      for (var i = 0; i < tempCycleList.length; i++) {
        print(
            '------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>****************************************************************************************************************************');

        List<Activitylist> tempList = [];
        for (var j = 0; j < getactivitymodel.data.length; j++) {
          if (tempCycleList[i] == getactivitymodel.data[j].title) {
            tempList.add(getactivitymodel.data[j]);
          }
        }
        ActivityCycleList activityCycleList = ActivityCycleList(
            activityList: tempList,
            cycleName: tempCycleList[i],
            cycleTime: tempList.first.toTime);
        activitylist.add(activityCycleList);
      }
      // activitylistCurrent.clear();
      update();
    }
    // actualtime = getactivitymodel.actualTime;
    // endingtime = getactivitymodel.totalTime;
    update();
  }

  getactivityLocal({
     int? cycle,
     DateTime? cyclestarttime ,
  }) async {
    activitylistCurrent.clear();
    List<Activitylist> tempActivityList = [];
    List<String> tempCycleList = [];

    // tempActivityList = getactivitymodel.data;
    selectedSubCatIdList.forEach((element) {
      print("Product Title: "+element.title);
      if (tempCycleList.contains(element.title) == false) {
        tempCycleList.add(element.title);
      }
    });

    print(tempCycleList.length);

    // activitylist.clear();
    for (var i = 0; i < tempCycleList.length; i++) {
      List<Activitylist> tempList = [];

      for (var j = 0; j < selectedSubCatIdList.length; j++) {
        Activitylist activitylist = Activitylist(
            categoryId: selectedSubCatIdList[j].catogoryid,
            categoryTitle: selectedSubCatIdList[j].categoryName,
            createdAt: DateTime.now(),
            fromTime: "00:00:00",
            id: 0,
            subCategory: selectedSubCatIdList[j].name,
            subTitle: selectedSubCatIdList[j].name,
            title: selectedSubCatIdList[j].title,
            toTime: "00:00:00",
            updatedAt: DateTime.now(),
            value: "");
        tempList.add(activitylist);
      }

      ActivityCycleList activityCycleList = ActivityCycleList(
          activityList: tempList,
          cycleName: tempCycleList[i],
          cycleTime: tempList.first.toTime);
      activitylistCurrent.add(activityCycleList);
    }


    if(activitylistCurrent.isEmpty){
        ActivityCycleList activityCycleList = ActivityCycleList(
                                activityList: [
                                  Activitylist(
                                      categoryId: "",
                                      categoryTitle: "",
                                      createdAt: DateTime.now(),
                                      fromTime: "",
                                      id: -1,
                                      subCategory: "",
                                      subTitle: "",
                                      title: "",
                                      toTime: "",
                                      updatedAt: DateTime.now(),
                                      value: "")
                                ],
                                cycleName: "Cycle$cycle",
                                cycleTime:
                                    "${cyclestarttime!.hour}:${cyclestarttime.minute}:${cyclestarttime.second}");
                           activitylistCurrent
                                .add(activityCycleList);
    }

    update();
  }

  DeleteSubcatogoryApiServices deleteSubcatogoryApiServices =
      DeleteSubcatogoryApiServices();
  Future deletesubcatogory() async {
    dio.Response<dynamic> response =
        await deleteSubcatogoryApiServices.deletesubcatogoryapi();

    print(
        "---------::::::::::::::::delete sub catogory response:::::::::::::::::::::::::_______________;");
    print("delete sub catogory response ");
    getcatogory();
    print(response.statusCode);

//     Get.snackbar(
//       response.statusCode.toString(),
//       response.data.toString(),
//      backgroundColor: Colors.red,

// snackPosition: SnackPosition.BOTTOM    );
    print(response.data);
  }

  DeleteActivityApiServices deleteActivityApiServices =
      DeleteActivityApiServices();
  Future deleteactivity() async {
    dio.Response<dynamic> response =
        await deleteActivityApiServices.deleteactivityapi(appid: '21346');

    print(
        "---------::::::::::::::::::::::::::::::::::::::::::::::::::_______________;");
    print("delete response ");
    print(response.statusCode);
    print(response.data);

//     Get.snackbar(
//       response.statusCode.toString(),
//       response.data.toString(),
//      backgroundColor: Colors.red,

// snackPosition: SnackPosition.BOTTOM);
    getactivity(appid: '21346');
  }

  Future deleteactivityOnStart() async {
    dio.Response<dynamic> response =
        await deleteActivityApiServices.deleteactivityapi(appid: '21346');

    print(
        "---------::::::::::::::::::::::::::::::::::::::::::::::::::_______________;");
    print("delete response ");
    print(response.statusCode);
    print(response.data);

//     Get.snackbar(
//       response.statusCode.toString(),
//       response.data.toString(),
//      backgroundColor: Colors.red,

// snackPosition: SnackPosition.BOTTOM);
    getactivityonStart(appid: '21346');
  }

  sharePdf({
    required String aminDrome,
    required String cppValue,
    required String etCO2,
    required DateTime cycleTime,
    required int efficiency
  }) async {
    final pdf = pw.Document();

    List<List<ActivityCycleList>> subLists = [];

    print("changes --------------------->>");
    print(
        "-----------------------------------------------------------------------------------------------------------------");

    print(activitylist.length);

    for (var i = 0; i < activitylist.length; i += 6) {
      var end = i + 6;
      if (end > activitylist.length) {
        end = activitylist.length;
      }
      var sublist = activitylist.sublist(i, end);
      subLists.add(sublist);
    }
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(subLists);
    print(subLists.length);
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');
    print(
        '================================================================================');

    for (int p = 0; p < subLists.length; p++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.SizedBox(
                  height: 10,
                ),
                if (p == 0)
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Container(
                        width: 110,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'Overall CPR Time',
                          style: const pw.TextStyle(color: PdfColors.grey),
                        ),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      //   if (tactapiController.isNotEmpty)
                      pw.Container(
                        width: 100,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "00:00:00",
                          style: const pw.TextStyle(color: PdfColors.grey),
                        ),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Container(
                        width: 100,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          overallCprTime.value,
                          style: const pw.TextStyle(color: PdfColors.grey),
                        ),
                      )
                    ],
                  ),
                if (p == 0)
                  pw.SizedBox(
                    height: 20,
                  ),
                if (p == 0)
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Container(
                        width: 110,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'Actual Time',
                          style: const pw.TextStyle(color: PdfColors.grey),
                        ),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      //   if (tactapiController.isNotEmpty)
                      pw.Container(
                        width: 100,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          actualtime,
                          style: const pw.TextStyle(color: PdfColors.grey),
                        ),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Container(
                        width: 100,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          actualTimetotal.value,
                          style: pw.TextStyle(color: PdfColors.grey),
                        ),
                      )
                    ],
                  ),
                pw.SizedBox(
                  height: 20,
                ),
                for (int index = 0; index < subLists[p].length; index++)
                  pw.Column(
                    children: [
                       pw.SizedBox(
                  height: 20,
                ),
                      pw.Row(
                        children: [
                          pw.Text(
                            "${subLists[p][index].cycleName} - ${subLists[p][index].cycleTime}",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 18,
                                color: PdfColors.blue),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      for (int i = 0;
                          i < subLists[p][index].activityList.length;
                          i++)
                        subLists[p][index].activityList[i].value == "empty"
                            ? pw.Container(
                                height: 5,
                              )
                            : pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    width: 100,
                                    alignment: pw.Alignment.centerLeft,
                                    child: pw.Text(
                                      subLists[p][index]
                                          .activityList[i]
                                          .categoryTitle,
                                      style:
                                          pw.TextStyle(color: PdfColors.grey),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    height: 10,
                                  ),
                                  pw.Container(
                                    width: 100,
                                    alignment: pw.Alignment.centerLeft,
                                    child: pw.Text(
                                      subLists[p][index]
                                          .activityList[i]
                                          .subTitle,
                                      style:
                                          pw.TextStyle(color: PdfColors.grey),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    height: 10,
                                  ),
                                  pw.Container(
                                    width: 100,
                                    alignment: pw.Alignment.centerLeft,
                                    child: pw.Text(
                                      subLists[p][index]
                                                  .activityList[i]
                                                  .value ==
                                              "null"
                                          ? " "
                                          : subLists[p][index]
                                              .activityList[i]
                                              .value,
                                      style:
                                          pw.TextStyle(color: PdfColors.grey),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                    ],
                  ),
                pw.SizedBox(
                  height: 20,
                ),
                for (int index = 0; index < activitylistCurrent.length; index++)
                  pw.Column(
                    children: [
                      pw.Row(
                        children: [
                          pw.Text(
                            "${activitylistCurrent[index].cycleName} - ${cycleTime.hour}:${cycleTime.minute}:${cycleTime.second}",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 18,
                                color: PdfColors.blue),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      for (int i = 0;
                          i < activitylistCurrent[index].activityList.length;
                          i++)
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Container(
                              width: 100,
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                activitylistCurrent[index]
                                    .activityList[i]
                                    .categoryTitle,
                                style:
                                    const pw.TextStyle(color: PdfColors.grey),
                              ),
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            pw.Container(
                              width: 100,
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                activitylistCurrent[index]
                                    .activityList[i]
                                    .subTitle,
                                style:
                                    const pw.TextStyle(color: PdfColors.grey),
                              ),
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            if (activitylistCurrent[index]
                                    .activityList[i]
                                    .subTitle ==
                                "Amiodarone")
                              pw.Container(
                                width: 100,
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  aminDrome,
                                  style: const pw.TextStyle(color: PdfColors.grey),
                                ),
                              ),
                            if (activitylistCurrent[index]
                                    .activityList[i]
                                    .subTitle ==
                                "CPP")
                              pw.Container(
                                width: 100,
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  cppValue,
                                  style: pw.TextStyle(color: PdfColors.grey),
                                ),
                              ),
                            if (activitylistCurrent[index]
                                    .activityList[i]
                                    .subTitle ==
                                "EtCO2")
                              pw.Container(
                                width: 100,
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  etCO2,
                                  style: const pw.TextStyle(color: PdfColors.grey),
                                ),
                              ),
                            if (activitylistCurrent[index]
                                        .activityList[i]
                                        .subTitle ==
                                    "Amiodarone" &&
                                activitylistCurrent[index]
                                        .activityList[i]
                                        .subTitle !=
                                    "CPP")
                              pw.Container(
                                width: 100,
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  " ",
                                  style: pw.TextStyle(color: PdfColors.grey),
                                ),
                              ),
                            pw.SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      pw.SizedBox(height: 40),
                      if (subLists.length - 1 == p)
                        pw.Text(
                          'Congratulations you have Achieved $efficiency% Efficiency',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 25,
                              color: PdfColors.blue),
                        ),

pw.SizedBox(height: 30,),

               if(efficiency >= 0 && efficiency <= 59)
                 pw.Text(
                      'Poor',
                      textAlign: pw. TextAlign.center,
                      style: pw. TextStyle(
                          fontWeight: pw. FontWeight.bold,
                          fontSize: 27,
                          color: PdfColors.red),
                    ),
             if(efficiency >= 60 && efficiency <= 79)
                           pw.Text(
                      'Better',
                      textAlign: pw. TextAlign.center,
                      style: pw. TextStyle(
                          fontWeight: pw. FontWeight.bold,
                          fontSize: 27,
                          color: PdfColors.orange),
                    ),
               if(efficiency >= 90 && efficiency <= 95)
                           pw.Text(
                      'Good',
                      textAlign: pw. TextAlign.center,
                      style: pw. TextStyle(
                          fontWeight: pw. FontWeight.bold,
                          fontSize: 27,
                          color: PdfColors.orange),
                    ),
                                 if(efficiency >= 80 && efficiency <= 89)
                               pw.Text(
                      'Excellent',
                      textAlign: pw. TextAlign.center,
                      style: pw. TextStyle(
                          fontWeight: pw. FontWeight.bold,
                          fontSize: 27,
                          color: PdfColors.green),
                    ),
                             if(efficiency >= 96 && efficiency <= 100)
                                     pw.Text(
                      'Outstanding',
                      textAlign: pw. TextAlign.center,
                      style: pw. TextStyle(
                          fontWeight: pw. FontWeight.bold,
                          fontSize: 27,
                          color: PdfColors.green),
                    ),
                                  //  Text(
                                  //     "Efficiency out of range",
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 27,
                                  //         color: kblue),
                                  //   ),        
                                    ],
                  )
              ],
            ); // Center
          })); //
    }

// On Flutter, use the [path_provider](https://pub.dev/packages/path_provider) library:
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/tackt_report.pdf");
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles(
      [XFile(file.path, bytes: await file.readAsBytes())],
      text: "TACT",
      subject: "Report Details",
    );
  }
}
