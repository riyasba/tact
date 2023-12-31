import 'dart:async';

import 'package:alarm/alarm.dart';

import 'package:alarm/model/alarm_settings.dart';

import 'package:flutter_application_1/controller/tact_api_controller.dart';

import 'package:flutter_application_1/models/store_activity_list_model.dart';

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
  DateTime cyclestarttime = DateTime.now();

  final controller = Get.put(counterController());
  var typevalue;

  String? selectedOption;
  String selectedOption2 = '150mg';
  bool _isRunning = true;
  bool isflashon = false;
  bool isplay1 = false;
  bool isplay = false;
  bool isEnable = false;
  bool isreaload = false;
  bool showPlayButtom = false;
  final _controller = CountDownController();
  final _controller2 = CountDownController();

//String selectedrythem=selectedOption;

  //var typevalue;

  void handleRadioValueChanged(
    String? value,
  ) {
    setState(() {
      selectedOption = value!;
      print('${selectedOption}');
      var sub_id = selectedOption;
      print('============${sub_id}===========');
    });
  }

  void handleRadioValueChanged2(String? value) {
    setState(() {
      selectedOption2 = value!;
    });
  }

  int cycle = 1;
  var endtime;
  var starttime;
  List<dynamic> typelist = [];
  List<dynamic> catogorylist = [];

  final tactapiController = Get.find<TactApiController>();
  @override
  void initState() {
    super.initState();
    tactapiController.getcatogory();
    // tactapiController.getactivity();
// startTimer();
    loadAlarms();

    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );

    //tactapiController.getsubcatogory(id: 1);
    // tactapiController.gettype(typevalue: "rhythm");
    // tactapiController.gettype(typevalue: "shock");
    //  tactapiController.gettype(typevalue: "drug");
    // tactapiController.gettype(typevalue: "rythm");
    // tactapiController.gettype(typevalue: "rythm");
  }

  void loadAlarms() {
    setState(
      () {
        alarms = Alarm.getAlarms();
        alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
      },
    );
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ExampleAlarmRingScreen(alarmSettings: alarmSettings),
      ),
    );
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
    playFLASHAudio();
    _enableTorch(context); // Turn on the flashlight

    // Turn off the flashlight after a delay (e.g., 2 seconds)
    Future.delayed(
      Duration(seconds: 2),
      () {
        _disableTorch(context);
      },
    );
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

  audio.AudioPlayer audioPlayer2 = audio.AudioPlayer();
  void playFLASHAudio() async {
    String audioPath =
        'images/flashaudio.mp3'; // Replace with your audio file path

    await audioPlayer2.play(
      audio.AssetSource(audioPath),
      volume: 100,
    );
  }

  final player = AudioPlayer();

  audio.AudioPlayer audioPlayer = audio.AudioPlayer();

  setListen(int second) async {
    if (second == 104) {
      final duration = await player.setAsset('assets/images/1.45sec-alarm.mp3');
      player.play();
    } else if (second == 119) {
      final duration = await player.setAsset('assets/images/1.45sec-alarm.mp3');
      player.play();

      await Future.delayed(Duration(seconds: 3));
      player.stop();
    }
  }

  void loop() {
    audioPlayer.setReleaseMode(audio.ReleaseMode.loop);
  }

  void playAudio() async {
    String audioPath =
        'images/120BPMMetronome.mp3'; // Replace with your audio file path

    await audioPlayer.play(
      audio.AssetSource(audioPath),
      volume: 100,
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    subscription?.cancel();
    audioPlayer.stop();
    player.stop();
    super.dispose();
  }

  audioSoundManage() async {
    if (controller.count > 120) {
      await audioPlayer.setPlaybackRate(1);
      await audioPlayer.setVolume(1);
    } else if (controller.count > 118) {
      await audioPlayer.setPlaybackRate(0.9);
      await audioPlayer.setVolume(0.9);
    } else if (controller.count > 116) {
      await audioPlayer.setPlaybackRate(0.8);
      await audioPlayer.setVolume(0.8);
    } else if (controller.count > 114) {
      await audioPlayer.setPlaybackRate(0.7);
      await audioPlayer.setVolume(0.7);
    } else if (controller.count > 112) {
      await audioPlayer.setPlaybackRate(0.6);
      await audioPlayer.setVolume(0.6);
    } else if (controller.count > 110) {
      await audioPlayer.setPlaybackRate(0.5);
      await audioPlayer.setVolume(0.5);
    } else if (controller.count > 108) {
      await audioPlayer.setPlaybackRate(0.4);
      await audioPlayer.setVolume(0.4);
    } else if (controller.count > 106) {
      await audioPlayer.setPlaybackRate(0.3);
      await audioPlayer.setVolume(0.3);
    } else if (controller.count > 104) {
      await audioPlayer.setPlaybackRate(0.2);
      await audioPlayer.setVolume(0.2);
    } else if (controller.count < 102) {
      await audioPlayer.setPlaybackRate(0.1);
      await audioPlayer.setVolume(0.1);
    }
  }

  double _currentSliderValue = 20;
  late List<AlarmSettings> alarms;
  static StreamSubscription? subscription;

  Timer? _timer;
  int tempOverallCtime = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        tempOverallCtime++;
        tactapiController.overallCprTime(formatHHMMSS(tempOverallCtime));
        tactapiController.actualTimetotal(_controller2.getTime());
      },
    );
  }

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    // if (hours == 0) {
    //   return "$minutesStr:$secondsStr";
    // }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kwhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<TactApiController>(builder: (_) {
            return Column(
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
                                  child: const Icon(
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
                                        style: const TextStyle(
                                            color: Color(0xffF61212),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      if (controller.count != 120) {
                                        controller.increment();
                                        audioSoundManage();
                                      }
                                    },
                                    child: const Icon(Icons.add_circle_outline,
                                        size: 25)),
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
                        if (isEnable == false)
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
                          cyclestarttime = DateTime.now();
                        });
                        _controller2.start();
                        _controller.start();
                        startTimer();
                        _startFlashlightTimer();
                        playAudio();
                        audioSoundManage();

                        loop();
                        tactapiController.deleteactivity();
                        tactapiController.setDefaultGroupValue();
                        tactapiController.selectedSubCatIdList.clear();
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
                        child: const Center(
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
                              child: const Icon(Icons.flash_on),
                            ),
                            const Text('Flash'),
                          ],
                        ),
                        if (isEnable == false)
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
            );
          }),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                                duration: 3000,
                                initialDuration: 0,
                                controller: _controller2,
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 4,
                                ringColor: Colors.grey[300]!,
                                ringGradient: null,
                                fillColor:
                                    const Color.fromARGB(255, 128, 182, 252)!,
                                fillGradient: null,
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                backgroundGradient: null,
                                strokeWidth: 20.0,
                                strokeCap: StrokeCap.round,
                                textStyle: const TextStyle(
                                  fontSize: 25.0,
                                  //  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textFormat: CountdownTextFormat.HH_MM_SS,
                                isReverse: false,
                                isReverseAnimation: false,
                                isTimerTextShown: true,
                                autoStart: false,
                                onStart: () {
                                  debugPrint('Countdown Started');
                                },
                                onComplete: () {
                                  // Here, do whatever you want
                                  debugPrint('Countdown Ended');
                                },
                                onChange: (String timeStamp) {
                                  // Here, do whatever you want
                                  // debugPrint('Countdown Changed $timeStamp');
                                  // print("-------------->>timeStamp");
                                },
                                timeFormatterFunction:
                                    (defaultFormatterFunction, duration) {
                                  if (duration.inSeconds == 0) {
                                    // only format for '0'
                                    return "Start";
                                  } else {
                                    return Function.apply(
                                        defaultFormatterFunction, [duration]);
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (isplay1 == true)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isplay1 = false;
                                          //isplay = false;
                                        });
                                        _controller2.pause();
                                        //_controller.pause();
                                        // timerCr!.cancel();
                                      },
                                      child: const Icon(
                                        Icons.pause,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  if (isplay1 == false)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isplay1 = true;
                                          //isplay = true;
                                        });
                                        _controller2.resume();
                                        //_controller.resume();
                                      },
                                      child: const Icon(
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
                        onTap: () {},
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
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
                                  duration: 120,
                                  initialDuration: 0,
                                  controller: _controller,
                                  width: MediaQuery.of(context).size.width / 3,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  ringColor: Colors.grey[300]!,
                                  ringGradient: null,
                                  fillColor: Colors.orange,
                                  fillGradient: null,
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  backgroundGradient: null,
                                  strokeWidth: 20.0,
                                  strokeCap: StrokeCap.round,
                                  textStyle: const TextStyle(
                                    fontSize: 25.0,
                                    //  color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textFormat: CountdownTextFormat.HH_MM_SS,
                                  isReverse: false,
                                  isReverseAnimation: false,
                                  isTimerTextShown: true,
                                  autoStart: false,
                                  onStart: () {
                                    // Here, do whatever you want
                                    debugPrint(
                                        'Countdown Started ${_controller.getTime()}');
                                    starttime = _controller.getTime();

                                    print(
                                        '============================starttime========${starttime}=----------------------');
                                  },
                                  onComplete: () async {
                                    // Here, do whatever you want
                                    debugPrint('Countdown Ended');
                                    debugPrint(
                                        'Countdown ${_controller.getTime()}');
                                    endtime = _controller.getTime();
                                    print(
                                        '============================endtime========${endtime}=----------------------');
                                    if (_controller.getTime() == "00:02:00") {
                                      print(
                                          '============================endtime========${endtime}=----------------------???${tactapiController.selectedSubCatIdList.length}');

                                      print(
                                          '============================endtime========${endtime}=----------------------???${tactapiController.selectedSubCatIdList.length}');
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");
                                      print("-------------------->>>>>>>>>>>>");

                                      for (int i = 0;
                                          i <
                                              tactapiController
                                                  .selectedSubCatIdList.length;
                                          i++) {
                                        await Future.delayed(
                                            const Duration(milliseconds: 500));

                                        if (tactapiController
                                                .selectedSubCatIdList[i].name ==
                                            "CPP") {
                                          await tactapiController.storeactivity(
                                              value: _currentSliderValue
                                                  .round()
                                                  .toString(),
                                              c_id: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .catogoryid,
                                              s_id: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .subid,
                                              from_time: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .startingTime,
                                              to_time:
                                                  "${cyclestarttime.hour}:${cyclestarttime.minute}:${cyclestarttime.second}",
                                              title: 'Cycle$cycle');
                                        } else if (tactapiController
                                                .selectedSubCatIdList[i].name ==
                                            "Amiodarone") {
                                          await tactapiController.storeactivity(
                                              value: selectedOption2,
                                              c_id: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .catogoryid,
                                              s_id: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .subid,
                                              from_time: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .startingTime,
                                              to_time:
                                                  "${cyclestarttime .hour}:${cyclestarttime .minute}:${cyclestarttime .second}",
                                              title: 'Cycle$cycle');
                                        } else {
                                          await tactapiController.storeactivity(
                                              value: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .value,
                                              c_id: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .catogoryid,
                                              s_id: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .subid,
                                              from_time: tactapiController
                                                  .selectedSubCatIdList[i]
                                                  .startingTime,
                                              to_time:
                                                  "${cyclestarttime .hour}:${cyclestarttime .minute}:${cyclestarttime .second}",
                                              title: 'Cycle$cycle');
                                        }

                                        // Get.rawSnackbar(
                                        //   message: "Stored Cycle - ${tactapiController
                                        //         .selectedSubCatIdList[i].name}"
                                        // );
                                      }

                                      setState(
                                        () {
                                          cycle++;
                                          showPlayButtom = true;
                                          isreaload = true;
                                        },
                                      );
                                      // tactapiController.selectedSubCatIdList.clear();
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
                                  onChange: (String timeStamp) async {
                                    // Here, do whatever you want
                                    print("--------------------->>$timeStamp");
                                  },
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isplay == true
                                        ? _controller.getTime() == "00:02:00"
                                            ? InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    cyclestarttime =
                                                        DateTime.now();
                                                    isreaload = false;
                                                  });
                                                  _controller.restart();
                                                  // tactapiController.setDefaultGroupValue();
                                                  // player.stop();
                                                  // playAudio();
                                                  // loop();
                                                },
                                                child: Icon(
                                                  Icons.restart_alt,
                                                  color: Colors.amber[700],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isplay = false;
                                                    //isplay1 = false;
                                                  });
                                                  //audioPlayer.stop();
                                                  _controller.pause();
                                                  //_controller2.pause();
                                                  // timerCr!.cancel();
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
                                                //isplay1 = true;
                                              });
                                              //_controller2.resume();
                                              _controller.resume();
                                              // _startFlashlightTimer();
                                              // playAudio();
                                              // loop();
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
                                    isplay == true
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isplay = true;
                                                });
                                                _controller.restart(
                                                    duration: 200);
                                                //  _startFlashlightTimer();
                                              },
                                              child: Icon(
                                                Icons.restart_alt,
                                                color: Colors.amber[700],
                                              ),
                                            ),
                                          ),
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
////
                  ///

                  GetBuilder<TactApiController>(builder: (_) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tactapiController.catogorylist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              if (tactapiController.catogorylist[index].index ==
                                  0) {
                                tactapiController.catogorylist[index].index = 1;

                                tactapiController.update();
                              } else {
                                tactapiController.catogorylist[index].index = 0;
                                tactapiController.update();
                              }
                              //  tactapiController.update();
                            },
                            child: tactapiController
                                        .catogorylist[index].index ==
                                    0
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
                                          offset: const Offset(0,
                                              3), // changes position of shadow
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
                                              Text(
                                                  'Choose ${tactapiController.catogorylist[index].title}',
                                                  style: maxfont),
                                              const Icon(
                                                  Icons.arrow_drop_down_rounded)
                                            ],
                                          ),
                                          ksizedbox10,
                                          GestureDetector(
                                            onTap: () {
                                              var txtControllerrythem =
                                                  TextEditingController();
                                              _showTextFieldDialog(
                                                context,
                                                "Rhythm ",
                                                "Enter Rhythm",
                                                txtControllerrythem,
                                                tactapiController
                                                    .catogorylist[index].id
                                                    .toString(),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit_square,
                                                  color: kblue,
                                                ),
                                                kwidth5,
                                                Text('Customize',
                                                    style: minfont),
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
                                          offset: const Offset(0,
                                              3), // changes position of shadow
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    'Choose ${tactapiController.catogorylist[index].title}',
                                                    style: maxfont),
                                                const Icon(
                                                    Icons.arrow_drop_up_rounded)
                                              ],
                                            ),
                                          ),
                                          ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: tactapiController
                                                  .getDatList(tactapiController
                                                      .catogorylist[index].id)
                                                  .length,
                                              itemBuilder: (context, index2) {
                                                // The itemBuilder callback is called for each item in the list.
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      RadioListTile(
                                                        title: Text(
                                                            tactapiController
                                                                .getDatList(
                                                                    tactapiController
                                                                        .catogorylist[
                                                                            index]
                                                                        .id)[
                                                                    index2]
                                                                .subTitle,
                                                            style: minfont),
                                                        value: tactapiController
                                                            .getDatList(
                                                                tactapiController
                                                                    .catogorylist[
                                                                        index]
                                                                    .id)[index2]
                                                            .id
                                                            .toString(),
                                                        groupValue: tactapiController
                                                            .getGroupValue(
                                                                tactapiController
                                                                    .catogorylist[
                                                                        index]
                                                                    .id),
                                                        onChanged: (
                                                          String? value,
                                                        ) {
                                                          setState(() {
                                                            tactapiController
                                                                .addGroupValue(
                                                                    tactapiController
                                                                        .catogorylist[
                                                                            index]
                                                                        .id,
                                                                    value!);

                                                            // selectedOption =
                                                            //     value;
                                                            StoreActivityListModel storeActivityListModel = StoreActivityListModel(
                                                                value: "null",
                                                                catogoryid: tactapiController
                                                                    .catogorylist[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                name: tactapiController
                                                                    .getDatList(
                                                                        tactapiController
                                                                            .catogorylist[
                                                                                index]
                                                                            .id)[
                                                                        index2]
                                                                    .subTitle,
                                                                subid: value,
                                                                startingTime:
                                                                    _controller2
                                                                        .getTime()
                                                                        .toString());

                                                            var tempId;
                                                            for (int i = 0;
                                                                i <
                                                                    tactapiController
                                                                        .selectedSubCatIdList
                                                                        .length;
                                                                i++) {
                                                              var value2 =
                                                                  tactapiController
                                                                      .selectedSubCatIdList[i];
                                                              if (value2
                                                                      .catogoryid ==
                                                                  storeActivityListModel
                                                                      .catogoryid) {
                                                                tempId = i;
                                                              }
                                                            }

                                                            if (tempId !=
                                                                null) {
                                                              tactapiController
                                                                  .selectedSubCatIdList
                                                                  .removeAt(
                                                                      tempId);
                                                              // Get.rawSnackbar(
                                                              //   message: "Removed from list index $tempId"
                                                              // );
                                                              tactapiController
                                                                  .selectedSubCatIdList
                                                                  .add(
                                                                      storeActivityListModel);
                                                              //   Get.rawSnackbar(
                                                              //   message: "Added to list "
                                                              // );
                                                            } else {
                                                              tactapiController
                                                                  .selectedSubCatIdList
                                                                  .add(
                                                                      storeActivityListModel);
                                                              //   Get.rawSnackbar(
                                                              //   message: "Added to list "
                                                              // );
                                                            }
                                                          });
                                                        },
                                                      ),
                                                      kwidth5,
                                                      ksizedbox10,
                                                      if (tactapiController
                                                                  .getDatList(
                                                                      tactapiController
                                                                          .catogorylist[
                                                                              index]
                                                                          .id)[
                                                                      index2]
                                                                  .subTitle ==
                                                              "CPP" &&
                                                          tactapiController.getGroupValue(
                                                                  tactapiController
                                                                      .catogorylist[
                                                                          index]
                                                                      .id) ==
                                                              tactapiController
                                                                  .getDatList(
                                                                      tactapiController
                                                                          .catogorylist[
                                                                              index]
                                                                          .id)[
                                                                      index2]
                                                                  .id
                                                                  .toString())
                                                        Slider(
                                                          value:
                                                              _currentSliderValue,
                                                          max: 100,
                                                          divisions: 100,
                                                          label:
                                                              _currentSliderValue
                                                                  .round()
                                                                  .toString(),
                                                          onChanged: (double
                                                              value) async {
                                                            setState(() {
                                                              _currentSliderValue =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                      if (tactapiController
                                                                  .getDatList(
                                                                      tactapiController
                                                                          .catogorylist[
                                                                              index]
                                                                          .id)[
                                                                      index2]
                                                                  .subTitle ==
                                                              "Amiodarone" &&
                                                          tactapiController.getGroupValue(
                                                                  tactapiController
                                                                      .catogorylist[
                                                                          index]
                                                                      .id) ==
                                                              tactapiController
                                                                  .getDatList(
                                                                      tactapiController
                                                                          .catogorylist[
                                                                              index]
                                                                          .id)[
                                                                      index2]
                                                                  .id
                                                                  .toString())
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      50),
                                                          child: Column(
                                                            children: [
                                                              RadioListTile(
                                                                title: Text(
                                                                    "150mg",
                                                                    style:
                                                                        minfont),
                                                                value: "150mg",
                                                                groupValue:
                                                                    selectedOption2,
                                                                onChanged: (
                                                                  String? value,
                                                                ) {
                                                                  //update value here
                                                                  setState(() {
                                                                    selectedOption2 =
                                                                        value!;
                                                                  });
                                                                },
                                                              ),
                                                              RadioListTile(
                                                                title: Text(
                                                                    "300mg",
                                                                    style:
                                                                        minfont),
                                                                value: "300mg",
                                                                groupValue:
                                                                    selectedOption2,
                                                                onChanged: (
                                                                  String? value,
                                                                ) {
                                                                  //update value here
                                                                  setState(() {
                                                                    selectedOption2 =
                                                                        value!;
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ksizedbox10,
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
                                                var txtControllerrythem =
                                                    TextEditingController();
                                                _showTextFieldDialog(
                                                  context,
                                                  "Customize",
                                                  "Enter value",
                                                  txtControllerrythem,
                                                  tactapiController
                                                      .catogorylist[index].id
                                                      .toString(),
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.edit_square,
                                                    color: kblue,
                                                  ),
                                                  kwidth5,
                                                  Text('Customize',
                                                      style: minfont)
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
                        );
                      },
                    );
                  }),

                  ksizedbox20,

                  GestureDetector(
                    onTap: () {
                      _disableTorch(context);
                      tactapiController.deleteactivity();
                      tactapiController.setDefaultGroupValue();
                      setState(() {
                        isEnable = false;
                        audioPlayer.stop();
                        audioPlayer2.stop();
                        player.stop();
                      });
                      int efficiency = tactapiController.getEfficiency(
                          actualTime: tactapiController.actualTimetotal.value,
                          overallTime: tactapiController.overallCprTime.value);
                      Get.off(SuccessScreen(
                        efficiency: efficiency.toString(),
                      ));
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
                                          tactapiController.activitylist[index]
                                              .activityList.length;
                                      i++)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size.width * 0.28,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            tactapiController
                                                .activitylist[index]
                                                .activityList[i]
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
                                                .activitylist[index]
                                                .activityList[i]
                                                .subTitle,
                                            style: minfont,
                                          ),
                                        ),
                                        ksizedbox10,
                                        Container(
                                          width: size.width * 0.28,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            tactapiController
                                                        .activitylist[index]
                                                        .activityList[i]
                                                        .value ==
                                                    "null"
                                                ? " "
                                                : tactapiController
                                                    .activitylist[index]
                                                    .activityList[i]
                                                    .value,
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
                        ksizedbox10,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isEnable == false)
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
    String label, TextEditingController textController, String id) async {
  String textFieldValue = '';
  //final TextEditingController textController;
  final tactapiController = Get.find<TactApiController>();
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
                  //api call

                  tactapiController.storesubcatogory(
                      title: textController.text,
                      description: 'test',
                      categoryid: id);
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
