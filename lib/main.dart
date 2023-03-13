import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Home%20Module/View/home_screen.dart';
import 'package:hr_management_system/Login%20Module/View/login_screen.dart';
import 'package:hr_management_system/Splash%20Module/View/splash_screen.dart';
import 'package:hr_management_system/Utils/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // set status bar color to transparent
      // statusBarBrightness: Brightness.dark, // set status bar brightness
      // statusBarIconBrightness: Brightness.light,
      // set status bar icon brightness
    ));
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return GetMaterialApp(
              theme: ThemeData(fontFamily: 'Rubik'),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}
