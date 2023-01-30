import 'package:flutter/material.dart';
import 'package:hr_management_system/Sign-Up%20Module/View/personal_information.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/custom_textbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final items = [
    'Matric',
    'FSC',
    'BSC',
    'BS',
    'BA',
    'MA',
  ];
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
          text: "Add Employee",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.only(top: SizeConfig.heightMultiplier*10),
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            children: [
              Text("Information Here",
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
                  Text("Salary",
                      style:
                          TextStyle(color: AppColors.textlight, fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              CustomTextbox(
                text: "Ammount in pkr",
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
                  Text("Designation",
                      style:
                          TextStyle(color: AppColors.textlight, fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              CustomTextbox(
                text: "designation here",
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
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                  Text("Education",
                      style:
                          TextStyle(color: AppColors.textlight, fontSize: 16),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                width: SizeConfig.widthMultiplier * 87,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.textbox,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.textbox,
                          blurRadius: 5.0,
                          offset: Offset(0, 2))
                    ]),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text("Select"),
                    value: value,
                    isExpanded: true,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textlight,
                    ),
                    iconSize: 32,
                    dropdownColor: AppColors.textbox,
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(
                      () => this.value = value,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 4,
              ),
              Container(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: CustomButton(
                  callback: () {
                    Navigator.push(context, CustomTransition(PersonalInformation()));
                    // {
                    //   Get.snackbar("Error", "Please fill all Fields",backgroundColor: Colors.black38,colorText: Colors.white,snackPosition: SnackPosition.TOP);
                    // }
                  },
                  title: "Continue",
                  width: SizeConfig.widthMultiplier * 100,
                ),
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
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

class CustomTransition extends PageRouteBuilder {
  final Widget page;

  CustomTransition(this.page)
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: page,
        ),
  );
}