import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/app/data/constands/constands.dart';

import 'package:flutter_application_1/models/get_activity_model.dart';
import 'package:flutter_application_1/models/get_catogory_model.dart';

import 'package:flutter_application_1/models/get_subcatogory_model.dart';
import 'package:flutter_application_1/models/store_activity_list_model.dart';
import 'package:flutter_application_1/services/networks/delete_activity_api_service.dart';

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

    return finalResult.round();
  }

  StoreActivityApiService activitylogapiservice = StoreActivityApiService();

  storeactivity(
      {required String c_id,
      required String s_id,
      required String from_time,
      required String to_time,
      required String value,
      required String title}) async {
    dio.Response<dynamic> response =
        await activitylogapiservice.storeactivityapi(
            c_id: c_id,
            s_id: s_id,
            from_time: from_time,
            to_time: to_time,
            title: title,
            value: value);
    // Get.snackbar(
    //   response.statusCode.toString(),
    //     response.data.toString(),
    //     backgroundColor: Colors.red,
    //     snackPosition: SnackPosition.BOTTOM
    // );

    getactivity();
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
  var actualtime = '00:00:00';
  var endingtime = '00:00:00';
  getactivity() async {
    activitylist.clear();
    dio.Response<dynamic> response =
        await getactivityapiservice.getactivityapi();

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

      update();
    }
    // actualtime = getactivitymodel.actualTime;
    // endingtime = getactivitymodel.totalTime;
    update();
  }

  DeleteActivityApiServices deleteActivityApiServices =
      DeleteActivityApiServices();
  Future deleteactivity() async {
    dio.Response<dynamic> response =
        await deleteActivityApiServices.deleteactivityapi();

    print(
        "---------::::::::::::::::::::::::::::::::::::::::::::::::::_______________;");
    print("delete response ");
    print(response.statusCode);
    print(response.data);

    getactivity();
  }

  sharePdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                height: 10,
              ),
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
                      style: pw.TextStyle(color: PdfColors.grey),
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
                      style: pw.TextStyle(color: PdfColors.grey),
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
              pw.SizedBox(
                height: 20,
              ),
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
                      style: pw.TextStyle(color: PdfColors.grey),
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
                      style: pw.TextStyle(color: PdfColors.grey),
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
              for (int index = 0; index < activitylist.length; index++)
                pw.Column(
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          "${activitylist[index].cycleName} - ${activitylist[index].cycleTime}",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 18,
                              color: PdfColors.blue),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    for (int i = 0;
                        i < activitylist[index].activityList.length;
                        i++)
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 100,
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              activitylist[index].activityList[i].categoryTitle,
                              style: pw.TextStyle(color: PdfColors.grey),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.Container(
                            width: 100,
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              activitylist[index].activityList[i].subTitle,
                              style: pw.TextStyle(color: PdfColors.grey),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.Container(
                            width: 100,
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              activitylist[index].activityList[i].value ==
                                      "null"
                                  ? " "
                                  : activitylist[index].activityList[i].value,
                              style: pw.TextStyle(color: PdfColors.grey),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                  ],
                )
            ],
          ); // Center
        })); //

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
