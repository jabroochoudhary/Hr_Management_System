import 'package:flutter/material.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/custom_textbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class PersonalInformation extends StatefulWidget {
  PersonalInformation({Key? key}) : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
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
          text: "Personal information",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.heightMultiplier * 87,
          // margin: EdgeInsets.only(top: SizeConfig.heightMultiplier*10),
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Personal Information",
                      style: TextStyle(
                          color: AppColors.coloredtext,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.start),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 4,
                      ),
                      Text("Childrens",
                          style: TextStyle(
                              color: AppColors.textlight, fontSize: 16),
                          textAlign: TextAlign.start),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  CustomTextbox(
                    text: "No of Children",
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
                      Text("Spouse",
                          style: TextStyle(
                              color: AppColors.textlight, fontSize: 16),
                          textAlign: TextAlign.start),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  CustomTextbox(
                    text: "Spouse",
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 4,
                      ),
                      Text("Address",
                          style: TextStyle(
                              color: AppColors.textlight, fontSize: 16),
                          textAlign: TextAlign.start),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  CustomTextbox(
                    text: "Address here",
                    maxLine: 3,
                    height: SizeConfig.heightMultiplier * 13,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: CustomButton(
                      callback: () {},
                      title: "Create Account",
                      width: SizeConfig.widthMultiplier * 50,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
