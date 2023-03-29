import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:hr_management_system/Sign-Up%20Module/view_model/sign_up_view_model.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/custom_textbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/loading_indicator.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/Utils/textbox_with_label.dart';
import 'package:lottie/lottie.dart';

import '../../Login Module/Components/google_button.dart';
import '../model/sign_up_mode.dart';

class HrSignup extends StatelessWidget {
  SignUpModel? hrData;
  bool isHR;
  HrSignup({this.isHR = false, this.hrData, Key? key}) : super(key: key);

  final _controllerSignUp = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    if (hrData != null) {
      _controllerSignUp.isSignUpGoogleDone.value = isHR;
      _controllerSignUp.userNameController.value.text =
          hrData!.userFullName.toString();
      _controllerSignUp.userContactNoController.value.text =
          hrData!.personalContactNo.toString();
      _controllerSignUp.userageController.value.text = hrData!.age.toString();
      _controllerSignUp.useremailController.value.text =
          hrData!.email.toString();
      _controllerSignUp.userpasswordController.value.text =
          hrData!.password.toString();
      _controllerSignUp.companyAddressController.value.text =
          hrData!.companyAddress.toString();
      _controllerSignUp.companyNameController.value.text =
          hrData!.companyName.toString();
      _controllerSignUp.companyDomainController.value.text =
          hrData!.companyDomain.toString();
      _controllerSignUp.officePhoneNoController.value.text =
          hrData!.officePhoneNo.toString();
    }

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: _controllerSignUp.isSignUpGoogleDone.value
            ? AppBar(
                // leading: IconButton(
                //   onPressed: () {
                //     Get.back();
                //   },
                //   icon: Icon(Icons.arrow_back_ios_sharp),
                // ),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                // bottomOpacity: 0,
                elevation: 0,
                flexibleSpace: CustomAppbar(
                  text: "Sign Up",
                ))
            : null,
        body: _controllerSignUp.isSignUpGoogleDone.value
            ? SingleChildScrollView(
                child: Container(
                  // margin: EdgeInsets.only(top: SizeConfig.heightMultiplier*10),
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      TextFieldWithLabel().textFieldLabel(
                        label: "Full Name",
                        hint: "Enter your full name",
                        textEditingController:
                            _controllerSignUp.userNameController.value,
                      ),
                      TextFieldWithLabel().textFieldLabel(
                        label: "Age",
                        hint: "Enter your age",
                        isNumber: true,
                        textEditingController:
                            _controllerSignUp.userageController.value,
                      ),
                      TextFieldWithLabel().textFieldLabel(
                        label: "Company Name",
                        hint: "Enter company name",
                        textEditingController:
                            _controllerSignUp.companyNameController.value,
                        isReadOnly: isHR,
                      ),
                      TextFieldWithLabel().textFieldLabel(
                        label: "Company Address",
                        hint: "Enter company address",
                        textEditingController:
                            _controllerSignUp.companyAddressController.value,
                      ),
                      TextFieldWithLabel().textFieldLabel(
                        label: "Company Domain",
                        hint: "Enter company domain",
                        textEditingController:
                            _controllerSignUp.companyDomainController.value,
                        isReadOnly: isHR,
                      ),
                      TextFieldWithLabel().textFieldLabel(
                        label: "Office Phone No",
                        hint: "Enter office phone no.",
                        textEditingController:
                            _controllerSignUp.officePhoneNoController.value,
                      ),
                      TextFieldWithLabel().textFieldLabel(
                        label: "Personal Contact No",
                        hint: "Enter personal contact no.",
                        textEditingController:
                            _controllerSignUp.userContactNoController.value,
                      ),
                      TextFieldWithLabel().textFieldLabel(
                        label: "Personal Email",
                        hint: "Enter personal email address",
                        textEditingController:
                            _controllerSignUp.useremailController.value,
                        isReadOnly: true,
                      ),
                      TextFieldWithLabel().textFieldLabel(
                        label: "Password",
                        hint: "Enter password",
                        textEditingController:
                            _controllerSignUp.userpasswordController.value,
                        isPassword: true,
                        isReadOnly: isHR,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 13, right: 13),
                        child: _controllerSignUp.isLoading.value
                            ? LoadingIndicator().loading()
                            : CustomButton(
                                callback: isHR
                                    ? () async {
                                        await _controllerSignUp
                                            .updateHRAccount(hrData!);
                                      }
                                    : () async {
                                        if (await _controllerSignUp
                                            .saveSignUpUserData()) {
                                          Get.back();
                                        } else {
                                          print("Some network Issue");
                                        }
                                      },
                                title: isHR ? "Update Account" : "Sign Up",
                                width: SizeConfig.widthMultiplier * 100,
                              ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.contain)),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
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
                    const Text(
                      "Register your Gmail to complete your profile",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textlight,
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 15),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 700),
                      child: _controllerSignUp.isLoading.value
                          ? LoadingIndicator().loading()
                          : GoogleButton(
                              callback: () {
                                _controllerSignUp.signupWithGoogle();
                                // _controllerSignUp.isLoading.value = true;
                              },
                              width: SizeConfig.widthMultiplier * 100,
                              title: "Continue with google account",
                            ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an HR Accoount? ",
                            style:
                                TextStyle(color: AppColors.text, fontSize: 14),
                            textAlign: TextAlign.start),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Text(" Login",
                                style: TextStyle(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.start)),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 5),
                  ],
                ),
              ),
      ),
    );
  }
}
