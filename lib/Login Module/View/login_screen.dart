import 'package:flutter/material.dart';
import 'package:hr_management_system/Home%20Module/Components/drawer.dart';
import 'package:hr_management_system/Home%20Module/View/home_screen.dart';
import 'package:hr_management_system/Login%20Module/Components/google_button.dart';
import 'package:hr_management_system/Login%20Module/view_model/login_view_model.dart';
import 'package:hr_management_system/Sign-Up%20Module/View/hr_signup.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/custom_textbox.dart';
import 'package:hr_management_system/Utils/loading_indicator.dart';
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

  final _controllerLogIn = Get.put(LogInViewModel());
  User _user = User.HR;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.contain)),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Lottie.asset(
                      "assets/welcome.json",
                      fit: BoxFit.fill,
                      height: 250,
                      width: 250,
                    ),
                  ),
                  DelayedDisplay(
                    delay: Duration(
                        milliseconds: initialDelay.inMilliseconds + 200),
                    child: const Text(
                      "Sign In",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  DelayedDisplay(
                    delay: Duration(
                        milliseconds: initialDelay.inMilliseconds + 300),
                    child: const Text(
                      "Please fill in the credentials",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 4),
                  DelayedDisplay(
                    delay: Duration(
                        milliseconds: initialDelay.inMilliseconds + 400),
                    child: CustomTextbox(
                      prefixIcon: const Icon(Icons.alternate_email_outlined,
                          color: AppColors.textboxicon, size: 20),
                      textEditingController:
                          _controllerLogIn.useremailController.value,
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  DelayedDisplay(
                    delay: Duration(
                        milliseconds: initialDelay.inMilliseconds + 500),
                    child: CustomTextbox(
                      text: "Password",
                      isPassword: true,
                      textEditingController:
                          _controllerLogIn.userpasswordController.value,
                      prefixIcon: const Icon(
                        Icons.key,
                        color: AppColors.textboxicon,
                        size: 20,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        // color: Colors.red,
                        width: SizeConfig.widthMultiplier * 30,
                        child: ListTile(
                          title: const Text('HR'),
                          textColor: AppColors.textlight,
                          horizontalTitleGap: 0,
                          leading: Radio<User>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.coloredtext),
                            value: User.HR,
                            groupValue: _user,
                            onChanged: (value) {
                              _controllerLogIn.isHrCheck.value = true;

                              setState(() {
                                _user = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        // color: Colors.yellow,
                        width: SizeConfig.widthMultiplier * 45,
                        child: ListTile(
                          textColor: AppColors.textlight,
                          title: const Text('Employee'),
                          horizontalTitleGap: 0,
                          leading: Radio<User>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.coloredtext),
                            value: User.Employee,
                            groupValue: _user,
                            onChanged: (value) {
                              _controllerLogIn.isHrCheck.value = false;
                              setState(() {
                                _user = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  DelayedDisplay(
                    delay: Duration(
                        milliseconds: initialDelay.inMilliseconds + 600),
                    child: _controllerLogIn.isLoading.value
                        ? Center(child: LoadingIndicator().loading())
                        : CustomButton(
                            callback: () async {
                              await _controllerLogIn.loigInWithEmailPassword();
                            },
                            title: "Login",
                            width: SizeConfig.widthMultiplier * 100,
                          ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  // DelayedDisplay(
                  //   delay: Duration(
                  //       milliseconds: initialDelay.inMilliseconds + 900),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       InkWell(
                  //           onTap: () {},
                  //           child: const Text(
                  //             "Forgot Password?",
                  //             style: TextStyle(
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w100,
                  //                 color: AppColors.coloredtext),
                  //           )),
                  //     ],
                  //   ),
                  // ),S
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  _controllerLogIn.isHrCheck.value
                      ? DelayedDisplay(
                          delay: Duration(
                              milliseconds: initialDelay.inMilliseconds + 700),
                          child: Align(
                            alignment: Alignment.center,
                            child: _controllerLogIn.isLoading.value
                                ? SizedBox()
                                : GoogleButton(
                                    callback: () async {
                                      await _controllerLogIn.lognInWithGoogle();
                                    },
                                    width: SizeConfig.widthMultiplier * 100,
                                    title: "Continue with google",
                                  ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  _controllerLogIn.isHrCheck.value
                      ? DelayedDisplay(
                          delay: Duration(
                              milliseconds: initialDelay.inMilliseconds + 800),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an HR account? ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    color: AppColors.textlight),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => HrSignup());
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.coloredtext),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.1,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
