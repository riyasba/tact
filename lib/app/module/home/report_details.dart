import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:flutter_application_1/app/module/home/home_screen.dart';
import 'package:flutter_application_1/controller/tact_api_controller.dart';
import 'package:get/get.dart';

class ReportDetails extends StatefulWidget {
  String aminDrome;
  String cppValue;
  String etco2;
  DateTime cycleTime;
  var efficiency;
  ReportDetails({
    super.key,
    required this.aminDrome,
    required this.cppValue,
    required this.etco2,
    required this.cycleTime,
    this.efficiency,
  });

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  final tactapiController = Get.find<TactApiController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: kblue,
        title: Text('Report Details'),
        actions: [
          IconButton(
            onPressed: () {
              tactapiController.sharePdf(
                  aminDrome: widget.aminDrome,
                  cppValue: widget.cppValue,
                  cycleTime: widget.cycleTime,
                  efficiency: widget.efficiency,
                  etCO2: widget.etco2
                  );
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<TactApiController>(builder: (_) {
            return Column(
              children: [
                ksizedbox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ksizedbox10,
                    Container(
                      width: size.width * 0.3,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Overall CPR Time',
                        style: minfont,
                      ),
                    ),
                    ksizedbox10,
                    //   if (tactapiController.isNotEmpty)
                    Container(
                      width: size.width * 0.28,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "00:00:00",
                        style: minfont,
                      ),
                    ),
                    ksizedbox10,
                    Container(
                      width: size.width * 0.28,
                      alignment: Alignment.centerLeft,
                      child: Obx(
                        () => Text(
                          tactapiController.overallCprTime.value,
                          style: minfont,
                        ),
                      ),
                    )
                  ],
                ),
                ksizedbox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ksizedbox10,
                    Container(
                      width: size.width * 0.3,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Actual Time',
                        style: minfont,
                      ),
                    ),
                    ksizedbox10,
                    //   if (tactapiController.isNotEmpty)
                    Container(
                      width: size.width * 0.28,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tactapiController.actualtime,
                        style: minfont,
                      ),
                    ),
                    ksizedbox10,
                    Container(
                      width: size.width * 0.28,
                      alignment: Alignment.centerLeft,
                      child: Obx(
                        () => Text(
                          tactapiController.actualTimetotal.value,
                          style: minfont,
                        ),
                      ),
                    )
                  ],
                ),
                ksizedbox20,
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tactapiController.activitylist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
    ksizedbox20,                    
                          Row(
                            children: [
                              Text(
                                "${tactapiController.activitylist[index].cycleName} - ${tactapiController.activitylist[index].cycleTime}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: kblue),
                              ),
                            ],
                          ),
                          ksizedbox10,
                          for (int i = 0;
                              i <
                                  tactapiController
                                      .activitylist[index].activityList.length;
                              i++)
                            tactapiController
                                                  .activitylist[index]
                                                  .activityList[i]
                                                  .value == "empty" ? Container(
                                                    height: 5,
                                                  ) : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.3,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tactapiController.activitylist[index]
                                        .activityList[i].categoryTitle,
                                    style: minfont,
                                  ),
                                ),
                                ksizedbox10,
                                Container(
                                  width: size.width * 0.28,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tactapiController.activitylist[index]
                                        .activityList[i].subTitle,
                                    style: minfont,
                                  ),
                                ),
                                ksizedbox10,
                                Container(
                                  width: size.width * 0.28,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tactapiController.activitylist[index]
                                                .activityList[i].value ==
                                            "null"
                                        ? " "
                                        : tactapiController.activitylist[index]
                                            .activityList[i].value,
                                    style: minfont,
                                  ),
                                ),
                                ksizedbox10,
                              ],
                            ),
                        ],
                      );
                    }),
                ksizedbox20,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tactapiController.activitylistCurrent.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${tactapiController.activitylistCurrent[index].cycleName} - ${widget.cycleTime.hour}:${widget.cycleTime.minute}:${widget.cycleTime.second}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: kblue),
                            ),
                          ],
                        ),
                        ksizedbox10,
                        for (int i = 0;
                            i <
                                tactapiController.activitylistCurrent[index]
                                    .activityList.length;
                            i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.3,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  tactapiController.activitylistCurrent[index]
                                      .activityList[i].categoryTitle,
                                  style: minfont,
                                ),
                              ),
                              ksizedbox10,
                              Container(
                                width: size.width * 0.28,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  tactapiController.activitylistCurrent[index]
                                      .activityList[i].subTitle,
                                  style: minfont,
                                ),
                              ),
                              ksizedbox10,
                              if (tactapiController.activitylistCurrent[index]
                                      .activityList[i].subTitle ==
                                  "Amiodarone")
                                Container(
                                  width: size.width * 0.28,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.aminDrome,
                                    style: minfont,
                                  ),
                                ),
                              if (tactapiController.activitylistCurrent[index]
                                      .activityList[i].subTitle ==
                                  "CPP")
                                Container(
                                  width: size.width * 0.28,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.cppValue,
                                    style: minfont,
                                  ),
                                ),
                              if (tactapiController.activitylistCurrent[index]
                                          .activityList[i].subTitle !=
                                      "CPP" &&
                                  tactapiController.activitylistCurrent[index]
                                          .activityList[i].subTitle !=
                                      "Amiodarone")
                                Container(
                                  width: size.width * 0.28,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " ",
                                    style: minfont,
                                  ),
                                ),
                              ksizedbox10,
                            ],
                          ),
                      ],
                    );
                  },
                ),
                ksizedbox30,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Congratulations you have Achieved ${widget.efficiency}% Efficiency based on CCF value',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: kblue),
                    ),
                    ksizedbox30,
              widget.efficiency >= 0 && widget.efficiency <= 59
                  ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                          'Needs improvements',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                              color: Colors.red),
                        ),
                         SizedBox(
                          height: 10,
                        ),
                          Text(
                          'Time taken to complete the activity was excessively High. You need to reduce the time for better results.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.red),
                        ),
                    ],
                  )
                  : widget.efficiency >= 60 && widget.efficiency <= 79
                      ? Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "Good",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27,
                                  color: korange),
                            ),
                            const SizedBox(
                          height: 10,
                        ),
                      Text(
                          'The time taken to complete the activity was higher. You need to reduce the time for better results.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: korange),
                        ),
                        ],
                      )
                      : widget.efficiency >= 80 && widget.efficiency <= 89
                          ? const Column(
                            children: [
                               Text(
                                  "Very Good",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                      color: Colors.yellow),
                                ),

                                  SizedBox(
                          height: 10,
                        ),
                      Text(
                          'Time taken to complete the activity was High. You need to reduce the time for better results.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color:  Colors.yellow),
                        ),
                            ],
                          )
                          : widget.efficiency >= 90 && widget.efficiency <= 100
                              ? const Column(
                                children: [
                                   Text(
                                      "Excellent",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27,
                                          color:Colors.green),
                                    ),
                                        SizedBox(
                          height: 10,
                        ),
                      Text(
                          'Time taken to complete the activity was slightly High. You need to reduce the time for better results.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color:  Colors.green),
                        ),
                                ],
                              )
                              : Text("Efficiency out of range",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27,
                                          color: kblue),
                                    ),   
                                    ],
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            tactapiController.deleteactivity();
            // tactapiController.deleteactivity();
            Get.offAll(HomeScreen());
          },
          child: Container(
            child: Center(
                child: Text(
              'Go To Home ',
              style: TextStyle(fontWeight: FontWeight.w600, color: kwhite),
            )),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: kblue, borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    );
  }
}

            // Text(
            //   'Chest Compression Fraction(CCF):(Actual Time /Overall CPR Time)x100',
            //   style: minfont,
            // )