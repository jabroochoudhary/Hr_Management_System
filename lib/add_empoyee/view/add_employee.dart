import 'package:flutter/material.dart';
import 'package:hr_management_system/Utils/textbox_with_label.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
        physics: BouncingScrollPhysics(),
        child: Container(
          // margin: EdgeInsets.only(top: SizeConfig.heightMultiplier*10),
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              const Text("Employee Information",
                  style: TextStyle(
                      color: AppColors.coloredtext,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textAlign: TextAlign.start),
              const SizedBox(height: 10),
              TextFieldWithLabel().textFieldLabel(
                label: "Name",
                hint: "Husnain",
              ),
              TextFieldWithLabel().textFieldLabel(
                label: "Father Name",
                hint: "Shah",
              ),
              TextFieldWithLabel().textFieldLabel(
                label: "Age",
                hint: "22",
                isNumber: true,
              ),
              TextFieldWithLabel().textFieldLabel(
                label: "CNIC",
                hint: "36603-00000000-0",
              ),
              TextFieldWithLabel().textFieldLabel(
                label: "Education",
                hint: "BS Computer Science",
              ),
              TextFieldWithLabel().textFieldLabel(
                label: "Experties",
                hint: "Flull stack flutter developer",
              ),
              TextFieldWithLabel().textFieldLabel(
                label: "Designation",
                hint: "Flutter Developer",
              ),
              const SizedBox(height: 10),
              const Text("Personal Information",
                  style: TextStyle(
                      color: AppColors.coloredtext,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textAlign: TextAlign.start),
              const SizedBox(height: 10),
              TextFieldWithLabel().textFieldLabel(
                label: "Spouse",
                hint: "1",
                isNumber: true,
              ),
              TextFieldWithLabel().textFieldLabel(
                label: "No of Dependent Children",
                hint: "3",
                isNumber: true,
              ),
              TextFieldWithLabel().textFieldLabel(
                label: "Address",
                hint: "Complete address",
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              const Text("Hr Section",
                  style: TextStyle(
                      color: AppColors.coloredtext,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textAlign: TextAlign.start),
              const SizedBox(height: 10),
              TextFieldWithLabel().textFieldLabel(
                label: "Monthly Salary",
                hint: "Ammount PkR e.g. 75000",
                isNumber: true,
              ),
              TextFieldWithLabel().textFieldLabel(
                  label: "Joining Date",
                  hint: "Tab to select date",
                  isReadOnly: true),
              TextFieldWithLabel().textFieldLabel(
                label: "Employee Email",
                hint: "husnain.shah@company.com",
              ),
              TextFieldWithLabel().textFieldLabel(
                label: "Employee Password",
                hint: "password atleast 6 charecters long",
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    "By using this credential, employee can chek his/her status",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 4,
              ),
              Container(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: CustomButton(
                  callback: () {
                    // Navigator.push(
                    //   context,
                    //   CustomTransition(
                    //     PersonalInformation(),
                    //   ),
                    // );
                  },
                  title: "Create Employee Account",
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
}

// class CustomTransition extends PageRouteBuilder {
//   final Widget page;

//   CustomTransition(this.page)
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               FadeTransition(
//             opacity: animation,
//             child: page,
//           ),
//         );
// }
