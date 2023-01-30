import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_management_system/Login%20Module/View/login_screen.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetologinScreen();
  }

  void _navigatetologinScreen() async {
    Timer(
      Duration(seconds: 3),
      (() => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 90),
              height: MediaQuery.of(context).size.width * 0.90,
              // width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppColors.background,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/logo.png",
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  "HR",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primarycolor,
                  ),
                ),
              ),
            ),
            Text(
              "Human Resources",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 10,
                fontWeight: FontWeight.w700,
                color: AppColors.primarycolor,
              ),
            ),
          ],
        ));
  }
}
