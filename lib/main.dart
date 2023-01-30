import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Splash%20Module/View/splash_screen.dart';
import 'package:hr_management_system/Utils/size_config.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return GetMaterialApp(
              theme: ThemeData(
                fontFamily: 'Rubik'
              ),
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}

