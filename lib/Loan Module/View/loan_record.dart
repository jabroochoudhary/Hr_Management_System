// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

import 'package:hr_management_system/Loan%20Module/View/loan_data.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class LoanRecord extends StatefulWidget {
  const LoanRecord({Key? key}) : super(key: key);

  @override
  _LoanRecordState createState() => _LoanRecordState();
}

class _LoanRecordState extends State<LoanRecord> {
  List names = [
    "Ali",
    "Asad",
    "Usman",
    "Shahzad",
    "Ali",
    "Usman",
    "Ali",
    "Shahzad",
    "Ali",
    "Asad",
  ];
  List leaves = [
    "10,000",
    "20,000",
    "5,000",
    "5,000",
    "20,000",
    "10,000",
    "90,000",
    "5,000",
    "10,000",
    "10,000",
    "50,000",
  ];
  List dates = [
    "13/07/2022",
    "18/07/2022",
    "Total",
    "Remaining",
  ];
  List record = [
    "10,000",
    "10,000",
    "20,000",
    "5,000",
  ];

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
          text: "Loan Record",
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text(
              "Remaining Loan of Employees",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: SizeConfig.heightMultiplier * 72,
            width: 400,
            // color: Colors.orange,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, CustomTransition(LoanData()));
                    },
                    splashColor: Colors.green,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      // width: SizeConfig.widthMultiplier*50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white70,
                            Colors.white70,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              names[index],
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              leaves[index],
                              style: TextStyle(color: Colors.black),
                            ),
                          ]),
                    ),
                  ),
                );
              },
              // ListTile(

              // )),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CustomButton(
            callback: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Submit Leave Record?'),
                  // content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              );
            },
            title: "Submit",
            width: SizeConfig.widthMultiplier * 70,
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
