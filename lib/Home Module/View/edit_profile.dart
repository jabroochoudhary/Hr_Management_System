import 'package:flutter/material.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/custom_textbox.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF5FAFF),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
          },
          icon: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded)),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        // bottomOpacity: 0,
        elevation: 0,
        flexibleSpace: CustomAppbar(
          text: "Edit Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // width: screenWidth,
          // height: screenHeight,
          padding: EdgeInsets.only(left: 19,right: 19),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              CircleAvatar(
                // backgroundColor: Color.fromRGBO(255, 255, 255, 0.4),
                backgroundColor: Colors.blue,
                radius: screenHeight * 0.06,
                backgroundImage: AssetImage("assets/profile_pic_side_menu.png"),
              ),
              SizedBox(
                height: screenHeight * 0.002,
              ),
              Text("Jabran Haider",
                  style: TextStyle(
                      color: AppColors.textlight, fontSize: 16),
                  textAlign: TextAlign.center),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier*3,

                  ),
                  Text("Change your name",
                      style: TextStyle(
                          color: AppColors.textlight,
                          fontSize: 14),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              CustomTextbox(
                text: "Name",
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier*3,

                  ),
                  Text("Change Email",
                      style: TextStyle(
                          color: AppColors.textlight,
                          fontSize: 14),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              CustomTextbox(
                text: "Email",
              ),

              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier*3,
                  ),
                  Text("Change Phone No",
                      style: GoogleFonts.rubik(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              CustomTextbox(
                text: "Enter Phone no",
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier*3,
                  ),
                  Text("Write your password",
                      style: TextStyle(
                          color: AppColors.textlight,
                          fontSize: 14),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              CustomTextbox(
                text: "Password",
                isPassword: true,
              ),
              SizedBox(height: SizeConfig.heightMultiplier*8),
              Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: CustomButton(
                  callback: () {

                  },
                  title: "Update",
                  width: screenWidth*0.6,
                ),
              ),
              SizedBox(height: screenHeight*0.01,),



            ],
          ),
        ),
      ),
    );
  }
}
