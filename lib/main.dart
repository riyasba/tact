import 'package:alarm/alarm.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/module/authentication/onbording/internet_page.dart';
import 'package:flutter_application_1/app/module/authentication/onbording/onbording_screen.dart';
import 'package:flutter_application_1/controller/tact_api_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Alarm.init(showDebugLogs: true);
  Get.put(TactApiController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WakelockPlus.enable();
    return GetMaterialApp(
      builder: (context, child) {
        return StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              final connenctivityResult = snapshot.data;
              if (connenctivityResult == ConnectivityResult.none ||
                  connenctivityResult == null) return InternetPage();

              return child!;
            });
      },
      debugShowCheckedModeBanner: false,
      home: OnbordingScreen1(),
    );
  }
}
