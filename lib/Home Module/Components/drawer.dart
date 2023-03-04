import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_management_system/Home%20Module/View/edit_profile.dart';
import 'package:hr_management_system/add_empoyee/view/add_employee.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: AppColors.background,

      // backgroundColor: Colors.black,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,

        children: [
          Container(
            height: SizeConfig.heightMultiplier * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.06, right: screenWidth * 0.1),
                        height: screenHeight * 0.23,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/profile_pic_side_menu.png"),
                                maxRadius: 45,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Shahzad Zafar",
                                      style: TextStyle(
                                          color: AppColors.textlight,
                                          fontSize: 20),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    height: screenHeight * 0.007,
                                  ),
                                  Text("shahzad.zafar@gmail.com",
                                      style: TextStyle(
                                          color: AppColors.textlight,
                                          fontSize: 11),
                                      textAlign: TextAlign.center),
                                ],
                              )
                            ]),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: screenWidth * 0.13,
                                right: screenWidth * 0.1),
                            child: Icon(Icons.person),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context, CustomTransition(EditProfile()));
                            },
                            child: Text("Edit Profile",
                                style: GoogleFonts.poppins(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: screenWidth * 0.13,
                                right: screenWidth * 0.1),
                            child: Icon(Icons.person_add_alt_outlined),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context, CustomTransition(SignupScreen()));
                            },
                            child: Text("Add Employee",
                                style: GoogleFonts.poppins(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Divider(
                        color: Colors.grey,
                        // height: 30,
                        thickness: 1,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: screenWidth * 0.13,
                                right: screenWidth * 0.1),
                            child: Icon(Icons.settings_rounded),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text("Setting",
                                style: GoogleFonts.poppins(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 14,
                      vertical: 40),
                  child: CustomButton(
                    callback: () {
                      Get.back();
                    },
                    isimage: true,
                    Image: "assets/carbon_logout.png",
                    title: "   Logout",
                    textAlign: TextAlign.center,
                    width: screenWidth * 0.5,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
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
