import 'package:flutter/material.dart';
import 'package:hr_management_system/Sign-Up%20Module/View/personal_information.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/custom_textbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class HrSignup extends StatefulWidget {

  HrSignup({Key? key}) : super(key: key);

  @override
  State<HrSignup> createState() => _HrSignupState();
}
int _groupValue = -1;
class _HrSignupState extends State<HrSignup> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_sharp),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        // bottomOpacity: 0,
        elevation: 0,
        flexibleSpace: CustomAppbar(
          text: "HR SignUp",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.only(top: SizeConfig.heightMultiplier*10),
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                  Text("Name",
                      style:
                      TextStyle(color: AppColors.textlight, fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              CustomTextbox(
                text: "Enter your name",
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                  Text("Father Name",
                      style:
                      TextStyle(color: AppColors.textlight, fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              CustomTextbox(
                text: "Enter your father name",
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                  Text("Age",
                      style:
                      TextStyle(color: AppColors.textlight, fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              CustomTextbox(
                text: "Enter your age",
                inputType: TextInputType.number,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                  Text("Previous Post",
                      style:
                      TextStyle(color: AppColors.textlight, fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              CustomTextbox(
                text: "Post Name",
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                  Text("Skills",
                      style:
                      TextStyle(color: AppColors.textlight, fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              CustomTextbox(
                height: SizeConfig.heightMultiplier * 10,
                text: "Enter your Skills",
                maxLine: 2,
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 15,
              ),
              Container(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: CustomButton(
                  callback: () {


                  },
                  title: "Sign Up",
                  width: SizeConfig.widthMultiplier * 100,
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an Accoount? ",
                      style: TextStyle(color: AppColors.text, fontSize: 14),
                      textAlign: TextAlign.start),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(" Login",
                          style: TextStyle(
                            color: AppColors.text,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start)),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String items) => DropdownMenuItem(
    value: items,
    child: Text(
      items,
      style: GoogleFonts.dmSans(
        fontWeight: FontWeight.w400,
        color: Color(0xffACA9A9),
        fontSize: 14,
      ),
    ),
  );
}