import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_management_system/Login%20Module/View/login_screen.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/profile/views/profile_view.dart';

class MyDrawer extends StatelessWidget {
  String? name;
  String? email;
  String? imgUrl;
  String? cName;
  GestureTapCallback? profilePressed;
  GestureTapCallback? employeesPressed;
  GestureTapCallback? salaryPressed;
  GestureTapCallback? settingsPressed;

  MyDrawer(
      {this.profilePressed,
      this.cName,
      this.salaryPressed,
      this.employeesPressed,
      this.settingsPressed,
      this.email,
      this.imgUrl,
      this.name,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
        ),
      ),

      // backgroundColor: Colors.black,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,

        children: [
          SizedBox(
            height: SizeConfig.heightMultiplier * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.06,
                            right: screenWidth * 0.01),
                        height: screenHeight * 0.23,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                imgUrl == null || imgUrl == ""
                                    ? const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/profile_pic_side_menu.png"),
                                        maxRadius: 45,
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(imgUrl.toString()),
                                        maxRadius: 45,
                                      ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 43,
                                      child: Text(
                                        name == null
                                            ? "Husnain"
                                            : name.toString(),
                                        overflow: TextOverflow.fade,
                                        style: const TextStyle(
                                            color: AppColors.textlight,
                                            fontSize: 20),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.007,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 43,
                                      child: Text(
                                        email == null
                                            ? "husnain@gmail.com"
                                            : email.toString(),
                                        style: const TextStyle(
                                          color: AppColors.textlight,
                                          fontSize: 11,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.007,
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 80,
                              child: Text(
                                cName == null
                                    ? "Husnain company"
                                    : cName.toString(),
                                style: const TextStyle(
                                  color: AppColors.coloredtext,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      tile(
                        icon: Icons.person,
                        title: "Profile",
                        onPressed: profilePressed,
                      ),
                      tile(
                        icon: Icons.groups_2_rounded,
                        title: "Employes",
                        onPressed: employeesPressed,
                      ),
                      tile(
                        icon: Icons.euro_symbol_sharp,
                        title: "Salary",
                        onPressed: salaryPressed,
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
                      Get.offAll(() => LoginScreen());
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
/////////////////////////////////////////////////////////////////

class MyEmpDrawer extends StatelessWidget {
  String? name;
  String? email;
  String? imgUrl;
  GestureTapCallback? editPressed;
  GestureTapCallback? salaryPressed;

  MyEmpDrawer(
      {this.salaryPressed,
      this.editPressed,
      this.email,
      this.imgUrl,
      this.name,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
        ),
      ),

      // backgroundColor: Colors.black,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,

        children: [
          SizedBox(
            height: SizeConfig.heightMultiplier * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.06,
                            right: screenWidth * 0.01),
                        height: screenHeight * 0.23,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            imgUrl == null || imgUrl == ""
                                ? const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/profile_pic_side_menu.png"),
                                    maxRadius: 45,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(imgUrl.toString()),
                                    maxRadius: 45,
                                  ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 43,
                                  child: Text(
                                    name == null ? "Husnain" : name.toString(),
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                        color: AppColors.textlight,
                                        fontSize: 20),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.007,
                                ),
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 43,
                                  child: Text(
                                    email == null
                                        ? "husnain@gmail.com"
                                        : email.toString(),
                                    style: const TextStyle(
                                      color: AppColors.textlight,
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      tile(
                        icon: Icons.person,
                        title: "Profile",
                        onPressed: () => Get.to(() => ProfileScreen()),
                      ),
                      tile(
                        icon: Icons.edit_document,
                        title: "Edit Profile",
                        onPressed: editPressed,
                      ),
                      tile(
                        icon: Icons.euro_symbol_sharp,
                        title: "Salary",
                        onPressed: salaryPressed,
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
                      Get.offAll(() => LoginScreen());
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

tile({
  GestureTapCallback? onPressed,
  String title = "Name",
  IconData icon = Icons.edit,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 0),
            child: Icon(icon),
          ),
          SizedBox(width: 15),
          Text(title,
              style: GoogleFonts.poppins(
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
              textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
