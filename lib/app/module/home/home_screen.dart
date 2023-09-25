import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:flutter_application_1/app/module/home/report_details.dart';
import 'package:flutter_application_1/app/module/home/ring.dart';
import 'package:flutter_application_1/app/module/home/suceess_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:torch_light/torch_light.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  final _controller = CountDownController();

  final controller = Get.put(counterController());

//  final int duration = 120;
  // final _controller2 = CountDownController();
  String selectedOption = 'Option 1';
  bool _isRunning = true;
  bool isflashon = false;
  bool isplay1 = false;
  bool isplay = false;
  bool isreaload = false;
  final _controller = CountDownController();
  final _controller2 = CountDownController();

  void handleRadioValueChanged(String? value) {
    setState(() {
      selectedOption = value!;
    });
  }

  @override
  void initState() {
    super.initState();
  
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExampleAlarmRingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  setListen(int second) async{
    if(second == 110){
  final player = AudioPlayer();                   // Create a player
final duration = await player.setAsset(           // Load a URL
    'assets/images/-154921.mp3');                 // Schemes: (https: | file: | asset: )
player.play(); 
    }
  }

  // Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
  //   final res = await showModalBottomSheet<bool?>(
  //       context: context,
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       builder: (context) {
  //         return FractionallySizedBox(
  //           heightFactor: 0.7,
  //           child: ExampleAlarmEditScreen(alarmSettings: settings),
  //         );
  //       });

  //   if (res != null && res == true) loadAlarms();
  // }
  final player = AudioPlayer();
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  late List<AlarmSettings> alarms;
  static StreamSubscription? subscription;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ksizedbox30,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //     ksizedbox10,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.count != 100) {
                                controller.decrement();
                              }
                            },
                            child: Icon(
                              Icons.remove_circle_outline,
                              size: 25,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  '${controller.count}',
                                  style: TextStyle(
                                      color: Color(0xffF61212),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                if (controller.count != 120)
                                  controller.increment();
                              },
                              child: Icon(Icons.add_circle_outline, size: 25)),
                        ],
                      ),
                      Text(
                        'Metronome',
                        style: TextStyle(
                          color: Color(0xffF61212),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isplay1 = true;
                        isplay = true;
                      });
                      _controller2.start();
                      _controller.start();
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Start',
                          style: TextStyle(
                              color: Color(0xff12175E),
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: kOrange,
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(129, 157, 196, 187),
                            Color(0xff81E89E),
                          ],
                        ),
                      ),
                    ),
                  ),
                  kwidth5,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (isflashon == false) {
                            setState(() {
                              isflashon = true;
                            });
                            print("-----------------> flsh oning");
                            _enableTorch(context);
                          } else {
                            setState(() {
                              isflashon = false;
                            });
                            print("------------>. flash off");
                            _disableTorch(context);
                          }
                        },
                        child: Icon(Icons.flash_on_rounded),
                      ),
                      Text('Flash'),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: [
                ksizedbox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.43,
                      height: size.height * 0.34,
                      decoration: BoxDecoration(
                        color: kwhite,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text(
                              'Actual Time',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue,
                              ),
                            ),
                            CircularCountDownTimer(
                              // Countdown duration in Seconds.
                              duration: 3000,

                              // Countdown initial elapsed Duration in Seconds.
                              initialDuration: 0,

                              // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                              controller: _controller2,

                              // Width of the Countdown Widget.
                              width: MediaQuery.of(context).size.width / 3,

                              // Height of the Countdown Widget.
                              height: MediaQuery.of(context).size.height / 4,

                              // Ring Color for Countdown Widget.
                              ringColor: Colors.grey[300]!,

                              // Ring Gradient for Countdown Widget.
                              ringGradient: null,

                              // Filling Color for Countdown Widget.
                              fillColor:
                                  const Color.fromARGB(255, 128, 182, 252)!,

                              // Filling Gradient for Countdown Widget.
                              fillGradient: null,

                              // Background Color for Countdown Widget.
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),

                              // Background Gradient for Countdown Widget.
                              backgroundGradient: null,

                              // Border Thickness of the Countdown Ring.
                              strokeWidth: 20.0,

                              // Begin and end contours with a flat edge and no extension.
                              strokeCap: StrokeCap.round,

                              // Text Style for Countdown Text.
                              textStyle: const TextStyle(
                                fontSize: 25.0,
                                //  color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),

                              // Format for the Countdown Text.
                              textFormat: CountdownTextFormat.HH_MM_SS,

                              // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                              isReverse: false,

                              // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                              isReverseAnimation: false,

                              // Handles visibility of the Countdown Text.
                              isTimerTextShown: true,

                              // Handles the timer start.
                              autoStart: false,

                              // This Callback will execute when the Countdown Starts.
                              onStart: () {
                                // Here, do whatever you want
                                debugPrint('Countdown Started');
                              },

                              // This Callback will execute when the Countdown Ends.
                              onComplete: () {
                                // Here, do whatever you want
                                debugPrint('Countdown Ended');
                              },

                              // This Callback will execute when the Countdown Changes.
                              onChange: (String timeStamp) {
                                // Here, do whatever you want
                                debugPrint('Countdown Changed $timeStamp');
                              },

                              /* 
          * Function to format the text.
          * Allows you to format the current duration to any String.
          * It also provides the default function in case you want to format specific moments
            as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
            the default behavior.
        */
                              timeFormatterFunction:
                                  (defaultFormatterFunction, duration) {
                                if (duration.inSeconds == 0) {
                                  // only format for '0'
                                  return "Start";
                                } else {
                                  // other durations by it's default format
                                  return Function.apply(
                                      defaultFormatterFunction, [duration]);
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                isplay1 == true
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isplay1 = false;
                                          });
                                          _controller2.pause();
                                        },
                                        child: Icon(
                                          Icons.pause,
                                          color: Colors.blue,
                                        ))
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isplay1 = true;
                                          });
                                          _controller2.resume();
                                        },
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.blue,
                                        ),
                                      ),
                                // GestureDetector(
                                //     onTap: () =>
                                //         _controller2.restart(duration: 200),
                                //     child: Icon(Icons.restart_alt)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // final alarmSettings = AlarmSettings(
                        //   id: 42,
                        //   dateTime: DateTime.now().add(Duration(minutes: 2)),
                        //   assetAudioPath: 'assets/images/marimba.mp3',
                        //   volumeMax: false,
                        // );
                        // Alarm.set(alarmSettings: alarmSettings);
                      },
                      child: Container(
                        width: size.width * 0.43,
                        height: size.height * 0.34,
                        decoration: BoxDecoration(
                          color: kwhite,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                '2 min Alarm',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.amber[700],
                                ),
                              ),
                              CircularCountDownTimer(
                                // Countdown duration in Seconds.
                                duration: 120,

                                // Countdown initial elapsed Duration in Seconds.
                                initialDuration: 0,

                                // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                                controller: _controller,

                                // Width of the Countdown Widget.
                                width: MediaQuery.of(context).size.width / 3,

                                // Height of the Countdown Widget.
                                height: MediaQuery.of(context).size.height / 4,

                                // Ring Color for Countdown Widget.
                                ringColor: Colors.grey[300]!,

                                // Ring Gradient for Countdown Widget.
                                ringGradient: null,

                                // Filling Color for Countdown Widget.
                                fillColor: Colors.orange,

                                // Filling Gradient for Countdown Widget.
                                fillGradient: null,

                                // Background Color for Countdown Widget.
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),

                                // Background Gradient for Countdown Widget.
                                backgroundGradient: null,

                                // Border Thickness of the Countdown Ring.
                                strokeWidth: 20.0,

                                // Begin and end contours with a flat edge and no extension.
                                strokeCap: StrokeCap.round,

                                // Text Style for Countdown Text.
                                textStyle: const TextStyle(
                                  fontSize: 25.0,
                                  //  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),

                                // Format for the Countdown Text.
                                textFormat: CountdownTextFormat.HH_MM_SS,

                                // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                                isReverse: false,

                                // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                                isReverseAnimation: false,

                                // Handles visibility of the Countdown Text.
                                isTimerTextShown: true,

                                // Handles the timer start.
                                autoStart: false,

                                // This Callback will execute when the Countdown Starts.
                                onStart: () {
                                  // Here, do whatever you want
                                  debugPrint('Countdown Started');
                                },
                                

                                // This Callback will execute when the Countdown Ends.
                                onComplete: () async {
                                  // Here, do whatever you want
                                  debugPrint('Countdown Ended');
                                  debugPrint(
                                      'Countdown ${_controller.getTime()}');

                                  if (_controller.getTime() == "00:02:00") {
                                    // setState(() {
                                    //   isreaload = true;
                                    //});
                                    isreaload = false;
                                    _controller.restart();
                                    // final alarmSettings =
                                    //     AlarmSettings(
                                    //   id: 42,
                                    //   dateTime: DateTime.now().subtract(Duration(
                                    //     seconds: 12
                                    //   )),
                                    //   assetAudioPath:
                                    //       'assets/images/marimba.mp3',
                                    //   volumeMax: false,
                                    // );
                                    // Alarm.set(
                                    //     alarmSettings:
                                    //         alarmSettings);

                                  

                                    // await player.play(AssetSource(
                                    //     'assets/images/-154921.mp3'));
                                  }
                                },

                                // This Callback will execute when the Countdown Changes.
                              
                                onChange: (String timeStamp) async{
                                  // Here, do whatever you want
                                 print("--------------------->>$timeStamp");

                                
                                },

                                /* 
                                * Function to format the text.
                                * Allows you to format the current duration to any String.
                                * It also provides the default function in case you want to format specific moments
                                  as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
                                  the default behavior.
                              */
                                timeFormatterFunction:
                                    (defaultFormatterFunction, duration) {
                                    
                                  if (duration.inSeconds == 0) {
                                    // only format for '0'
                                    return "Start";
                                  } else {
                                       setListen(duration.inSeconds);
                                    // other durations by it's default format
                                    return Function.apply(
                                        defaultFormatterFunction, [duration]);
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  isplay == true
                                      ? _controller.getTime() == "00:02:00"
                                          ? InkWell(
                                              onTap: () {
                                                isreaload = false;
                                                _controller.restart();
                                                // final alarmSettings =
                                                //     AlarmSettings(
                                                //   id: 42,
                                                //   dateTime: DateTime.now().add(
                                                //      const Duration(minutes: 2)),
                                                //   assetAudioPath:
                                                //       'assets/images/marimba.mp3',
                                                //   volumeMax: false,
                                                // );
                                                // Alarm.set(
                                                //     alarmSettings:
                                                //         alarmSettings);

                                                //  Alarm.stop(alarmSettings.id);
                                              },
                                              child: Icon(Icons.restore_rounded,
                                                  color: Colors.amber[700]))
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isplay = false;
                                                });
                                                _controller.pause();
                                              },
                                              child: Icon(
                                                Icons.pause,
                                                color: Colors.amber[700],
                                              ),
                                            )
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isplay = true;
                                            });
                                            _controller.resume();
                                            // final alarmSettings = AlarmSettings(
                                            //   id: 42,
                                            //   dateTime: DateTime.now()
                                            //       .add(Duration(minutes: 2)),
                                            //   assetAudioPath:
                                            //       'assets/images/marimba.mp3',
                                            //   volumeMax: false,
                                            // );
                                            // Alarm.set(
                                            //     alarmSettings: alarmSettings);
                                          },
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.amber[700],
                                          ),
                                        ),
                                  // GestureDetector(
                                  //     onTap: () =>
                                  //         _controller.restart(duration: 200),
                                  //     child: Icon(Icons.restart_alt)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ksizedbox20,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     _button(
                //       title: "Start",
                //       onPressed: () => _controller.start(),
                //     ),
                //     _button(
                //       title: "Pause",
                //       onPressed: () => _controller.pause(),
                //     ),
                //     _button(
                //       title: "Resume",
                //       onPressed: () => _controller.resume(),
                //     ),
                //     _button(
                //       title: "Restart",
                //       onPressed: () => _controller.restart(duration: 200),
                //     ),
                //   ],
                // ),
                ksizedbox30,
                GestureDetector(
                  onTap: () {
                    if (controller.ecgindex.value == 0) {
                      controller.ecgindex(1);
                    } else {
                      controller.ecgindex(0);
                    }
                    ;
                  },
                  child: controller.ecgindex.value == 0
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Choose Rhythm', style: maxfont),
                                    Icon(Icons.arrow_drop_down_rounded)
                                  ],
                                ),
                                ksizedbox10,
                                GestureDetector(
                                  onTap: () {
                                    var txtControllerrythem =
                                        TextEditingController();
                                    _showTextFieldDialog(context, "Rhythm",
                                        "Enter Rhythm", txtControllerrythem);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_square,
                                        color: kgrey,
                                      ),
                                      kwidth5,
                                      Text('Customize', style: minfont)
                                    ],
                                  ),
                                ),
                                ksizedbox10
                              ],
                            ),
                          ),
                          width: double.infinity,
                          //  height: 300,
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Choose Rhythm', style: maxfont),
                                      Icon(Icons.arrow_drop_up_rounded)
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.rythmList.length,
                                    itemBuilder: (context, index) {
                                      // The itemBuilder callback is called for each item in the list.
                                      return Container(
                                        child: Column(
                                          children: [
                                            RadioListTile(
                                              title: Text(
                                                  controller.rythmList[index]
                                                      .toString(),
                                                  style: minfont),
                                              value: 'v${index}',
                                              groupValue: selectedOption,
                                              onChanged:
                                                  handleRadioValueChanged,
                                            ),
                                            kwidth5,
                                            Divider(
                                              height: 1,
                                            ),
                                            ksizedbox10,
                                          ],
                                        ),
                                      );
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      var txtControllerrythem =
                                          TextEditingController();
                                      _showTextFieldDialog(context, "Rhythm",
                                          "Enter Rhythm", txtControllerrythem);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_square,
                                          color: kgrey,
                                        ),
                                        kwidth5,
                                        Text('Customize', style: minfont)
                                      ],
                                    ),
                                  ),
                                ),
                                ksizedbox10
                              ],
                            ),
                          ),
                          width: double.infinity,
                          //  height: 300,
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                ),
                ksizedbox20,
                InkWell(
                  onTap: () {
                    if (controller.shock.value == 0) {
                      controller.shock(1);
                    } else {
                      controller.shock(0);
                    }
                    ;
                  },
                  child: controller.shock.value == 0
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Choose Shock', style: maxfont),
                                    Icon(Icons.arrow_drop_down_rounded)
                                  ],
                                ),
                                ksizedbox10,
                                GestureDetector(
                                  onTap: () {
                                    var txtControllershock =
                                        TextEditingController();
                                    _showTextFieldDialog(context, "Shock",
                                        "Enter", txtControllershock);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_square,
                                        color: kgrey,
                                      ),
                                      kwidth5,
                                      Text('Customize', style: minfont)
                                    ],
                                  ),
                                ),
                                ksizedbox10
                              ],
                            ),
                          ),
                          width: double.infinity,
                          //  height: 300,
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          //  height: 300,
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Choose Shock', style: maxfont),
                                      Icon(Icons.arrow_drop_up_rounded)
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.shockList.length,
                                    itemBuilder: (context, index) {
                                      // The itemBuilder callback is called for each item in the list.
                                      return Container(
                                        child: Column(
                                          children: [
                                            RadioListTile(
                                              title: Text(
                                                  controller.shockList[index]
                                                      .toString(),
                                                  style: minfont),
                                              value: 'v${index}',
                                              groupValue: selectedOption,
                                              onChanged:
                                                  handleRadioValueChanged,
                                            ),
                                            kwidth5,
                                            Divider(
                                              height: 1,
                                            ),
                                            ksizedbox10,
                                          ],
                                        ),
                                      );
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      var txtControllershock =
                                          TextEditingController();
                                      _showTextFieldDialog(context, "Shock",
                                          "Enter", txtControllershock);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_square,
                                          color: kgrey,
                                        ),
                                        kwidth5,
                                        Text('Customize', style: minfont)
                                      ],
                                    ),
                                  ),
                                ),
                                ksizedbox10
                              ],
                            ),
                          ),
                        ),
                ),
                ksizedbox20,
                GestureDetector(
                  onTap: () {
                    if (controller.quality.value == 0) {
                      controller.quality(1);
                    } else {
                      controller.quality(0);
                    }
                    ;
                  },
                  child: controller.quality.value == 0
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Drug/Dose', style: maxfont),
                                    Icon(Icons.arrow_drop_down_rounded)
                                  ],
                                ),
                                ksizedbox10,
                                GestureDetector(
                                  onTap: () {
                                    var txtControllerdrug =
                                        TextEditingController();
                                    _showTextFieldDialog(context, "DRUG",
                                        "Enter", txtControllerdrug);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_square,
                                        color: kgrey,
                                      ),
                                      kwidth5,
                                      Text('Customize', style: minfont)
                                    ],
                                  ),
                                ),
                                ksizedbox10
                              ],
                            ),
                          ),
                          width: double.infinity,
                          //  height: 300,
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Drug / Dose', style: maxfont),
                                      Icon(Icons.arrow_drop_up_rounded)
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.drugList.length,
                                    itemBuilder: (context, index) {
                                      // The itemBuilder callback is called for each item in the list.
                                      return Container(
                                        child: Column(
                                          children: [
                                            RadioListTile(
                                              title: Text(
                                                  controller.drugList[index]
                                                      .toString(),
                                                  style: minfont),
                                              value: 'v${index}',
                                              groupValue: selectedOption,
                                              onChanged:
                                                  handleRadioValueChanged,
                                            ),
                                            kwidth5,
                                            Divider(
                                              height: 1,
                                            ),
                                            ksizedbox10,
                                          ],
                                        ),
                                      );
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      var txtControllerdrug =
                                          TextEditingController();
                                      _showTextFieldDialog(context, "DRUG",
                                          "Enter", txtControllerdrug);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_square,
                                          color: kgrey,
                                        ),
                                        kwidth5,
                                        Text('Customize', style: minfont)
                                      ],
                                    ),
                                  ),
                                ),
                                ksizedbox10
                              ],
                            ),
                          ),
                          width: double.infinity,
                          //  height: 300,
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                ),
                ksizedbox20,
                GestureDetector(
                  onTap: () {
                    if (controller.cpr.value == 0) {
                      controller.cpr(1);
                    } else {
                      controller.cpr(0);
                    }
                  },
                  child: controller.cpr.value == 0
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Quality CPR', style: maxfont),
                                    Icon(Icons.arrow_drop_down_rounded)
                                  ],
                                ),
                                ksizedbox10,
                                GestureDetector(
                                  onTap: () {
                                    var txtControllerCPR =
                                        TextEditingController();
                                    _showTextFieldDialog(context, "QUALITY CPR",
                                        "Enter", txtControllerCPR);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_square,
                                        color: kgrey,
                                      ),
                                      kwidth5,
                                      Text('Customize', style: minfont)
                                    ],
                                  ),
                                ),
                                ksizedbox10
                              ],
                            ),
                          ),
                          width: double.infinity,
                          //  height: 300,
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Quality CPR', style: maxfont),
                                      Icon(Icons.arrow_drop_up_rounded)
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.cprList.length,
                                    itemBuilder: (context, index) {
                                      // The itemBuilder callback is called for each item in the list.
                                      return Container(
                                        child: Column(
                                          children: [
                                            RadioListTile(
                                              title: Text(
                                                  controller.cprList[index]
                                                      .toString(),
                                                  style: minfont),
                                              value: 'v${index}',
                                              groupValue: selectedOption,
                                              onChanged:
                                                  handleRadioValueChanged,
                                            ),
                                            kwidth5,
                                            Divider(
                                              height: 1,
                                            ),
                                            ksizedbox10,
                                          ],
                                        ),
                                      );
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      var txtControllerCPR =
                                          TextEditingController();
                                      _showTextFieldDialog(
                                          context,
                                          "QUALITY CPR",
                                          "Enter",
                                          txtControllerCPR);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_square,
                                          color: kgrey,
                                        ),
                                        kwidth5,
                                        Text('Customize', style: minfont)
                                      ],
                                    ),
                                  ),
                                ),
                                ksizedbox10
                              ],
                            ),
                          ),
                          width: double.infinity,
                          //  height: 300,
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                ),
                ksizedbox20,
                GestureDetector(
                  onTap: () {
                    Get.to(SuccessScreen());
                  },
                  child: Container(
                    height: 50,
                    width: 140,
                    child: Center(
                      child: Text(
                        'ROSC Achieved',
                        style: TextStyle(
                            color: kwhite,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: kOrange,
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xffE77D7D),
                          Color.fromARGB(255, 229, 182, 182),
                        ],
                      ),
                    ),
                  ),
                ),
                ksizedbox10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Activity Log',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: kblue),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(ReportDetails());
                            },
                            child: Text(
                              'View all',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: kgrey),
                            ),
                          )
                        ],
                      ),
                      ksizedbox20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Overal CPR time',
                                style: minfont,
                              ),
                              ksizedbox10,
                              Text(
                                'Actual Time',
                                style: minfont,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '00:00:00',
                                style: minfont,
                              ),
                              ksizedbox10,
                              Text(
                                '00:00:00',
                                style: minfont,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '00:00:00',
                                style: minfont,
                              ),
                              ksizedbox10,
                              Text(
                                '00:00:00',
                                style: minfont,
                              ),
                            ],
                          )
                        ],
                      ),
                      ksizedbox20,
                      Row(
                        children: [
                          Text(
                            'Cycle 1',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: kblue),
                          ),
                        ],
                      ),
                      ksizedbox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ECG',
                                style: minfont,
                              ),
                              ksizedbox10,
                              Text(
                                'Medicine',
                                style: minfont,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '00:00:00',
                                style: minfont,
                              ),
                              ksizedbox10,
                              Text(
                                '00:00:00',
                                style: minfont,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'PVT',
                                style: minfont,
                              ),
                              ksizedbox10,
                              Text(
                                'Epinephrine',
                                style: minfont,
                              ),
                            ],
                          ),
                        ],
                      ),
                      ksizedbox20,
                      Row(
                        children: [
                          Text(
                            'Cycle 1',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: kblue),
                          ),
                        ],
                      ),
                      ksizedbox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ECG',
                                style: minfont,
                              ),
                              ksizedbox10,
                              Text(
                                'Medicine',
                                style: minfont,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '00:00:00',
                                style: minfont,
                              ),
                              ksizedbox10,
                              Text(
                                '00:00:00',
                                style: minfont,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'PVT',
                                style: minfont,
                              ),
                              ksizedbox10,
                              Text(
                                'Epinephrine',
                                style: minfont,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _enableTorch(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
      isflashon = true;
    } on Exception catch (_) {
      _showMessage('Could not enable torch', context);
    }
  }

  void _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _disableTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
      // isflashon = false;
    } on Exception catch (_) {
      _showMessage('Could not disable torch', context);
    }
  }
}

Future<void> _showTextFieldDialog(BuildContext context, String text,
    String label, TextEditingController textController) async {
  String textFieldValue = '';
  //final TextEditingController textController;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(text),
        content: Container(
          height: 50,
          width: double.infinity,
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
                label: Text(label), border: OutlineInputBorder()),
            onChanged: (value) {
              textFieldValue = value;
            },
          ),
        ),
        actions: <Widget>[
          Container(
            height: 34,
            width: 70,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(16)),
            child: TextButton(
              child: Center(
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 16, color: kwhite),
                ),
              ),
              onPressed: () {
                //     print('Entered text: ${textEditingController.text}');
                if (textController.text.isNotEmpty) {
                  if (text == "Rhythm") {
                    Get.find<counterController>()
                        .rythmList
                        .add(textController.text);
                  } else if (text == "Shock") {
                    Get.find<counterController>()
                        .shockList
                        .add(textController.text);
                  } else if (text == "DRUG") {
                    Get.find<counterController>()
                        .drugList
                        .add(textController.text);
                  } else if (text == "QUALITY CPR") {
                    Get.find<counterController>()
                        .cprList
                        .add(textController.text);
                  }
                }
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}

class counterController extends GetxController {
  final count = 110.obs;
  increment() => count.value++;
  decrement() => count.value--;
  reset() => count.value = 0;

  RxInt ecgindex = 0.obs;
  RxInt quality = 0.obs;
  RxInt cpr = 0.obs;
  RxInt stop = 0.obs;
  RxInt shock = 0.obs;

  List shockList = [
    'ASYSTOLE',
    '360/200/0(Non-Shockable)',
  ];

  List rythmList = ['VF', 'pVTPEA', 'ASYSTOLE', 'pp'];
  List drugList = ['150mg/300mg', 'Epinephrine 1mgAmiodarone', 'ASYSTOLE'];
  List cprList = ['CPP(0-100)', 'VF'];
}

Widget _button({required String title, VoidCallback? onPressed}) {
  return Expanded(
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Color.fromARGB(255, 0, 83, 151)),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
