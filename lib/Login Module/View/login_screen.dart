import 'package:flutter/material.dart';
import 'package:hr_management_system/Home%20Module/Components/drawer.dart';
import 'package:hr_management_system/Home%20Module/View/home_screen.dart';
import 'package:hr_management_system/Login%20Module/Components/abc.dart';
import 'package:hr_management_system/Login%20Module/Components/google_button.dart';
import 'package:hr_management_system/Sign-Up%20Module/View/hr_signup.dart';
import 'package:hr_management_system/Sign-Up%20Module/View/add_employee.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/custom_textbox.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:get/get.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:lottie/lottie.dart';
enum User { HR, Employee }

class LoginScreen extends StatefulWidget {

   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Duration initialDelay = Duration(milliseconds: 100);

  User _user = User.HR;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor: AppColors.background,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.contain)),
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.asset("assets/welcome.json"),
                // SizedBox(
                //   height: SizeConfig.heightMultiplier * 2,
                // ),
                DelayedDisplay(
                  delay: Duration(milliseconds: initialDelay.inMilliseconds + 200),
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 1),
                DelayedDisplay(
                  delay: Duration(milliseconds: initialDelay.inMilliseconds + 300),
                  child: Text(
                    "Please fill in the credentials",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textlight),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 4),
                DelayedDisplay(
                  delay: Duration(milliseconds: initialDelay.inMilliseconds + 400),
                  child: CustomTextbox(
                    prefixIcon: Icon(Icons.alternate_email_outlined,
                        color: AppColors.textboxicon,size: 20),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                DelayedDisplay(
                  delay: Duration(milliseconds: initialDelay.inMilliseconds + 500),
                  child: CustomTextbox(
                    text: "Password",
                    isPassword: true,
                    prefixIcon: Icon(Icons.key, color: AppColors.textboxicon,size: 20,),
                  ),
                ),
                Row(children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier*33,
                    child: ListTile(
                      title: Text('HR'),
                      textColor: AppColors.textlight,
                      leading: Radio<User>(
                        fillColor: MaterialStateColor.resolveWith((states) => AppColors.coloredtext),

                        value: User.HR,
                        groupValue: _user,
                        onChanged: (value) {
                          setState(() {
                            _user = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier*45,
                    child: ListTile(
                      textColor: AppColors.textlight,
                      title: Text('Employee'),
                      leading: Radio<User>(
                        fillColor: MaterialStateColor.resolveWith((states) => AppColors.coloredtext),
                        value: User.Employee,
                        groupValue: _user,
                        onChanged: (value) {
                          setState(() {
                            _user = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],),

                // SizedBox(height: SizeConfig.heightMultiplier * 6),
                DelayedDisplay(
                  delay: Duration(milliseconds: initialDelay.inMilliseconds + 600),
                  child: CustomButton(
                    callback: () {
                      Get.to(HomeScreen());
                    },
                    title: "Login",
                    width: SizeConfig.widthMultiplier * 100,
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                DelayedDisplay(
                  delay: Duration(milliseconds: initialDelay.inMilliseconds + 900),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {

                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w100,
                                color: AppColors.coloredtext
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                DelayedDisplay(
                  delay: Duration(milliseconds: initialDelay.inMilliseconds + 700),
                  child: GoogleButton(callback: () {

                  },
                    width: SizeConfig.widthMultiplier*100,
                    title: "Continue with google",

                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),

                DelayedDisplay(
                  delay: Duration(milliseconds: initialDelay.inMilliseconds + 800),
                  child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w100,
                                color: AppColors.textlight),
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w100,
                                color: AppColors.coloredtext
                            ),
                          )
                        ],
                      )
                  ),
                ),
                // SizedBox(
                //   height: SizeConfig.heightMultiplier * 0.1,
                // ),
                // DelayedDisplay(
                //   delay: Duration(milliseconds: initialDelay.inMilliseconds + 900),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       InkWell(
                //           onTap: () {
                //             Get.to(() => HrSignup());
                //           },
                //           child: Text(
                //             "Sign Up",
                //             style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w100,
                //                 color: AppColors.coloredtext
                //             ),
                //           )
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}

