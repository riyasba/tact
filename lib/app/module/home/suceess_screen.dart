import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:flutter_application_1/app/module/home/report_details.dart';
import 'package:flutter_application_1/controller/tact_api_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SuccessScreen extends StatefulWidget {
  int efficiency;
  SuccessScreen({super.key, required this.efficiency});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final tactapiController = Get.find<TactApiController>();
  DateTime cyclestarttime = DateTime.now();
  double _currentSliderValue = 20;
  String selectedOption2 = '150mg';

  @override
  void initState() {
    super.initState();
    toHomePage();
    //  checkForAuth();
  }

  toHomePage() async {
    await Future.delayed(const Duration(seconds: 2));

    int efficiency = tactapiController.getEfficiency(
        actualTime: tactapiController.actualTimetotal.value,
        overallTime: tactapiController.overallCprTime.value);

    Get.offAll(ReportDetails(
      aminDrome: selectedOption2,
      cppValue: _currentSliderValue.round().toString(),
      cycleTime: cyclestarttime,
      etco2: _currentSliderValue.round().toString(),
      efficiency: efficiency,
    ));
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: SvgPicture.asset('assets/images/Group 33.svg'),
              ),
              Text(
                'Congratulations you have Achieved ${widget.efficiency}% Efficiency based on CCF value',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: kblue),
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
        ),
      ),
    );
  }
}
