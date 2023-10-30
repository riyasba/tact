import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/module/authentication/onbording/onbording_screen.dart';
import 'package:flutter_application_1/controller/tact_api_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';



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
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  OnbordingScreen1(),
    );
  }
}

