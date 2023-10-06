import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/audioplayers.dart';
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
import 'package:audioplayers/audioplayers.dart' as audio;

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
  String selectedOption2 = 'Option 2';
  bool _isRunning = true;
  bool isflashon = false;
  bool isplay1 = false;
  bool isplay = false;
  bool isEnable = false;
  bool isreaload = false;
  bool showPlayButtom = false;
  final _controller = CountDownController();
  final _controller2 = CountDownController();

  void handleRadioValueChanged(String? value) {
    setState(() {
      selectedOption = value!;
    });
  }

  void handleRadioValueChanged2(String? value) {
    setState(() {
      selectedOption2 = value!;
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

  // flashtimer(int second) async {
  //   if (second == 6) {
  //     _enableTorch(context);
  //      Future.delayed(Duration(seconds: 2), () {
  //     _disableTorch(context);
  //   });
  //   }

  // }



  final List<String> items = List.generate(101, (index) => "$index");

  void _handleFlashlight() {
    _enableTorch(context); // Turn on the flashlight
    // Turn off the flashlight after a delay (e.g., 2 seconds)
    Future.delayed(Duration(seconds: 2), () {
      _disableTorch(context);
    });


  }



  Timer? timerCr;
  // Function to start the timer
  void _startFlashlightTimer() {
    Timer.periodic(
      Duration(seconds: 6),
      (timer) {
        setState(
          () {
            timerCr = timer;
          },
        );
        _handleFlashlight();
      },
    );
  }



  final player = AudioPlayer();

 audio. AudioPlayer audioPlayer = audio.AudioPlayer();




  setListen(int second) async {
    if (second == 110) {
      final duration = await player.setAsset('assets/images/-154921.mp3');
      player.play();
    } else {
      // timesound();
    }
    // await Future.delayed(const Duration(seconds: 2));
    
  }


  void loop() {
    audioPlayer.setReleaseMode(audio.ReleaseMode.loop);
}

  // timesound() async {




  //   final duration =
  //       await player.setAsset('assets/images/tick-tock-clock-01-84927.mp3');
  //   player.play();
  // }


  void playAudio() async {
  String audioPath = 'images/tic-tic-tic.mp3'; // Replace with your audio file path

 await audioPlayer.play(
    audio.AssetSource(audioPath),
    volume:100,
  );
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

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  audioSoundManage() async {
     if(controller.count > 120){
         await audioPlayer.setPlaybackRate(1);
         await audioPlayer.setVolume(1);
     } else if(controller.count > 118) {
         await audioPlayer.setPlaybackRate(0.9);
         await audioPlayer.setVolume(0.9);
    } else if(controller.count > 116) {
         await audioPlayer.setPlaybackRate(0.8);
         await audioPlayer.setVolume(0.8);
    } else if(controller.count > 114) {
         await audioPlayer.setPlaybackRate(0.7);
         await audioPlayer.setVolume(0.7);
    } else if(controller.count > 112) {
         await audioPlayer.setPlaybackRate(0.6);
         await audioPlayer.setVolume(0.6);
    } else if(controller.count > 110) {
         await audioPlayer.setPlaybackRate(0.5);
         await audioPlayer.setVolume(0.5);
    } else if(controller.count > 108) {
         await audioPlayer.setPlaybackRate(0.4);
         await audioPlayer.setVolume(0.4);
    } else if(controller.count > 106) {
         await audioPlayer.setPlaybackRate(0.3);
         await audioPlayer.setVolume(0.3);
    } else if(controller.count > 104) {
         await audioPlayer.setPlaybackRate(0.2);
         await audioPlayer.setVolume(0.2);
    } else if(controller.count < 102) {
         await audioPlayer.setPlaybackRate(0.1);
         await audioPlayer.setVolume(0.1);
    } 
  }

  double _currentSliderValue = 20;
  late List<AlarmSettings> alarms;
  static StreamSubscription? subscription;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(90.0),
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
                  Stack(
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
                                    audioSoundManage();
                                  }
                                },
                                child:const Icon(
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
                                      style:const TextStyle(
                                          color: Color(0xffF61212),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    if (controller.count != 120){
                                        controller.increment();
                                        audioSoundManage();
                                    }
                                      
                                  },
                                  child:const Icon(Icons.add_circle_outline, size: 25)),
                            ],
                          ),
                          const Text(
                            'Metronome',
                            style: TextStyle(
                              color: Color(0xffF61212),
                            ),
                          ),
                        ],
                      ),
                      if(isEnable == false)
                      Container(
                        height: 50,
                        width: 80,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isplay1 = true;
                        isplay = true;
                        isEnable = true;
                      });
                      _controller2.start();
                      _controller.start();
                      _startFlashlightTimer();
                      playAudio();
                      audioSoundManage();
                      loop();
                    },
                    child: Container(
                      height: 40,
                      width: 100,
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
                      child:const Center(
                        child: Text(
                          'Start',
                          style: TextStyle(
                              color: Color(0xff12175E),
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                     
                    ),
                  ),
                  kwidth5,
                  Stack(
                    children: [
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
                            child:const Icon(Icons.flash_on_rounded),
                          ),
                          const Text('Flash'),
                        ],
                      ),
                      if(isEnable == false)
                      Container(
                        height: 50,
                        width: 40,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
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
                          height: size.height * 0.35,
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                const Text(
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
                                    const  Color.fromARGB(255, 255, 255, 255),

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
                                      // timesound(duration.inSeconds);
                                      // other durations by it's default format
                                      return Function.apply(
                                          defaultFormatterFunction, [duration]);
                                    }
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (showPlayButtom && isplay1 == true)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isplay1 = false;
                                            isplay = false;
                                          });
                                          _controller2.pause();
                                          _controller.pause();
                                          timerCr!.cancel();
                                        },
                                        child:const Icon(
                                          Icons.pause,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    if (isplay1 == false)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isplay1 = true;
                                            isplay = true;
                                          });
                                          _controller2.resume();
                                          _controller.resume();
                                        },
                                        child:const Icon(
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
                            height: size.height * 0.35,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3), // changes position of shadow
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
                                    backgroundColor:const  Color.fromARGB(255, 255, 255, 255),

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
                                        setState(() {
                                          showPlayButtom = true;
                                          isreaload = true;
                                        });
                                        
                                        // _controller.restart();
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

                                    onChange: (String timeStamp) async {
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
                                                    playAudio();
                                                    loop();
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
                                                  child: Icon(Icons.play_arrow,
                                                      color: Colors.amber[700]))
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isplay = false;
                                                      isplay1 = false;
                                                    });
                                                    audioPlayer.stop();
                                                    _controller.pause();
                                                    _controller2.pause();
                                                    timerCr!.cancel();
                                                    setState(() {});
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
                                                  isplay1 = true;
                                                });
                                                _controller2.resume();
                                                _controller.resume();
                                                _startFlashlightTimer();
                                                playAudio();
                                               loop();
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

                    ksizedbox30,
                    GestureDetector(
                      onTap: () {
                        if (controller.ecgindex.value == 0) {
                          controller.ecgindex(1);
                        } else {
                          controller.ecgindex(0);
                        }
                      },
                      child: controller.ecgindex.value == 0
                          ? Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
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
                                          const Icon(Icons.arrow_drop_up_rounded)
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
                    // ksizedbox20,

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
                                    offset:const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Drug/Dose', style: maxfont),
                                        const Icon(Icons.arrow_drop_down_rounded)
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
                                    offset:const  Offset(0, 3), // changes position of shadow
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
                                          Text('Drug / Dose', style: maxfont),
                                          const Icon(Icons.arrow_drop_up_rounded)
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        physics:const NeverScrollableScrollPhysics(),
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
                                                ksizedbox10,
                                                if (index == 1 && selectedOption == "v1")
                                                     Column(
                                                       children: [
                                                         RadioListTile(
                                                  title: Text("150mg",
                                                          style: minfont),
                                                  value: 'a1',
                                                  groupValue: selectedOption2,
                                                  onChanged: handleRadioValueChanged2,
                                                        ),
                                                        RadioListTile(
                                                  title: Text("300mg",
                                                          style: minfont),
                                                  value: 'a2',
                                                  groupValue: selectedOption2,
                                                  onChanged: handleRadioValueChanged2,
                                                        ),
                                                       ],
                                                     ),
                                                kwidth5,
                                                const Divider(
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
                                    ksizedbox10,
                                  ],
                                ),
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
                                                  value: 'e${index}',
                                                  groupValue: selectedOption,
                                                  onChanged: 
                                                      handleRadioValueChanged,
                                                ),
                                                kwidth5,
                                                ksizedbox10,
                                                if (selectedOption == "e0" &&
                                                    index == 0)
                                                  Slider(
                                                    value: _currentSliderValue,
                                                    max: 100,
                                                    divisions: 5,
                                                    label: _currentSliderValue
                                                        .round()
                                                        .toString(),
                                                    onChanged: (double value) {
                                                      setState(() {
                                                        _currentSliderValue = value;
                                                      });
                                                    },
                                                  ),
                                                ksizedbox10,
                                                Divider(
                                                  height: 1,
                                                ),
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
                        if (controller.procedureindex.value == 0) {
                          controller.procedureindex(1);
                        } else {
                          controller.procedureindex(0);
                        }
                      },
                      child: controller.procedureindex.value == 0
                          ? Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Other Procedure', style: maxfont),
                                        Icon(Icons.arrow_drop_down_rounded)
                                      ],
                                    ),
                                    ksizedbox10,
                                    GestureDetector(
                                      onTap: () {
                                        var txtControllerrythem =
                                            TextEditingController();
                                        _showTextFieldDialog(context, "Procedure",
                                            "Enter Procedure", txtControllerrythem);
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
                                          Text('Choose Procedure', style: maxfont),
                                          Icon(Icons.arrow_drop_up_rounded)
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller.procedurelist.length,
                                        itemBuilder: (context, index) {
                                          // The itemBuilder callback is called for each item in the list.
                                          return Container(
                                            child: Column(
                                              children: [
                                                RadioListTile(
                                                  title: Text(
                                                      controller
                                                          .procedurelist[index]
                                                          .toString(),
                                                      style: minfont),
                                                  value: 'd${index}',
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
                                          _showTextFieldDialog(
                                              context,
                                              "Procedure",
                                              "Enter Procedure",
                                              txtControllerrythem);
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
                        setState(() {
                          isEnable = false;
                          audioPlayer.stop();
                        });
                        Get.to(const SuccessScreen());
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
          if(isEnable == false)
           Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withOpacity(0.7),
          ),
        ],
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

  RxInt procedureindex = 0.obs;
  RxInt ecgindex = 0.obs;
  RxInt quality = 0.obs;
  RxInt cpr = 0.obs;
  RxInt stop = 0.obs;
  RxInt shock = 0.obs;

  List shockList = [
    '360',
    '200',
    '0(Non-Shockable)',
  ];
  List procedurelist = [
    'IV Access',
    'IO Access',
    'Advanced Airway',
    'Blood Investigation',
    'Reversible Causes Disussion',
  ];
  List rythmList = [
    'VF',
    'pVT',
    'ASYSTOLE',
    'PEA',
  ];
  List drugList = [
    // '150mg',
    // '300mg',
    'Epinephrine 1mg',
    'Amiodarone',
    'ASYSTOLE',
    
  ];
  List amiodarone = [
    '150mg',
    '300mg',
  ];
  List cprList = [
    'CPP(0-100)',
    'VF',
  ];
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
