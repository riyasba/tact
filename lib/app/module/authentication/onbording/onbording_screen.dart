import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/home_screen.dart';

class OnbordingScreen1 extends StatelessWidget {
  const OnbordingScreen1({super.key});


  String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random();
  String result = '';
  for (var i = 0; i < length; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("assets/images/tact.jpeg")),
              ksizedbox30,
              const Text(
                'TACT',
                style: TextStyle(
                    fontSize: 32,
                    color: Color(0xff5B67CA),
                    fontWeight: FontWeight.bold),
              ),
              ksizedbox10,
           Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Good CPR saves life',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff5B67CA),
                    ),
                  ),
             ],
              ), 
              ksizedbox40,
              ksizedbox30,
              InkWell(onTap: () async{

               final prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token",generateRandomString(10));


                Get.to(HomeScreen());
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'Begin',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, color: kwhite),
                    ),
                  ),
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
