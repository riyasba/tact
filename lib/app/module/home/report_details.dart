import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:flutter_application_1/controller/tact_api_controller.dart';
import 'package:get/get.dart';

class ReportDetails extends StatefulWidget {
  const ReportDetails({super.key});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  final tactapiController = Get.find<TactApiController >();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text('Report Details'),
        actions: [
          IconButton(onPressed: (){
            tactapiController.sharePdf();
          }, icon: Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:   GetBuilder<TactApiController>(
          builder: (_) {
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
                              child: Obx(()=> Text(
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
                               child: Obx(()=> Text(
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
                                          Row(
                                            children: [
                                              Text(
                                                "${tactapiController
                                                    .activitylist[index].cycleName} - ${tactapiController
                                                    .activitylist[index].cycleTime}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color: kblue),
                                              ),
                                            ],
                                          ),
                                          ksizedbox10,
                                          for(int i =0;i<tactapiController
                                                    .activitylist[index].activityList.length;i++)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: size.width * 0.28,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  tactapiController
                                                  .activitylist[index].activityList[i]
                                                      .categoryTitle,
                                                  style: minfont,
                                                ),
                                              ),
                                              ksizedbox10,
                                               Container(
                                                  width: size.width * 0.28,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  tactapiController
                                                  .activitylist[index].activityList[i].subTitle,
                                                  style: minfont,
                                                ),
                                              ),
                                              ksizedbox10,
                                                  Container(
                                                      width: size.width * 0.28,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                 tactapiController
                                                  .activitylist[index].activityList[i].value == "null" ? " ": tactapiController
                                                  .activitylist[index].activityList[i].value,
                                                  style: minfont,
                                                ),
                                              ),
                                              ksizedbox10,
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
              ],
            );
          }
        ),
      ),
    );
  }
}

            // Text(
            //   'Chest Compression Fraction(CCF):(Actual Time /Overall CPR Time)x100',
            //   style: minfont,
            // )