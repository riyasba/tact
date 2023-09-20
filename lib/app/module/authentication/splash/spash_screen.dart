import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../data/constands/constands.dart';
import '../onbording/onbording_screen.dart';



class splash extends StatefulWidget {
  const splash({super.key});


  @override
  State<splash> createState() => _splashState();
}


class _splashState extends State<splash> {

  
  @override
  void initState() {
    super.initState();
 toHomePage() ;
  //  checkForAuth();
  }

  toHomePage() async {
    await Future.delayed(const Duration(seconds: 3));
Get.offAll(OnbordingScreen1());
 
  }

 
  // toLoginPage() async {
  //   await Future.delayed(const Duration(seconds: 2));

  //   // Get.offAll(
  //   //   () => BusinessLoginScreen(),
  //   // );
  // }

  // checkForAuth() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? authtoken = prefs.getString("auth_token");
  //   String? role = prefs.getString("role");
  //   print("Token is here");
  //   print(authtoken);
  //   if (authtoken == "null" || authtoken == null) {
  //     toLoginPage();
  //   } else {
  //     toHomePage();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
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
            //  ksizedbox30,
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
              ),  ],
        ),
      ),
    );
  }
}
