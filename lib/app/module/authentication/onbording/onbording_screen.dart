import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../home/home_screen.dart';

class OnbordingScreen1 extends StatelessWidget {
  const OnbordingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: SvgPicture.asset('assets/images/vector 1 1.svg'),
              ),
              ksizedbox30,
              Text(
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
              InkWell(onTap: (){Get.to(HomeScreen());},
                child: Container(
                  child: Center(
                    child: Text(
                      'Begin',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, color: kwhite),
                    ),
                  ),
                  height: 60,
                  width: double.infinity,
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
