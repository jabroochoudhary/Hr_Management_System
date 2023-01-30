// ignore_for_file: non_constant_identifier_names
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:hr_management_system/Attendence%20Module/Components/attendence_color.dart';
import 'package:hr_management_system/Attendence%20Module/Components/names.dart';
import 'package:hr_management_system/Attendence%20Module/Components/user_prefrences.dart';
import 'package:hr_management_system/Leave%20Record%20Module/View/leave_data.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class LeaveRecord extends StatefulWidget {
  const LeaveRecord({Key? key}) : super(key: key);

  @override
  _LeaveRecordState createState() => _LeaveRecordState();
}

class _LeaveRecordState extends State<LeaveRecord> {
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
    "1",
    "2",
    "1",
    "7",
    "5",
    "9",
    "5",
    "2",
    "1",
    "3",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
          text: "Leave Record",
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text(
              "Leaves of People here",
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
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, CustomTransition(LeaveData()));

                      // print(index);
                      // Get.defaultDialog(
                      //   backgroundColor: AppColors.background,
                      //   title: "Record",
                      //   titleStyle: TextStyle(
                      //     color: AppColors.textlight,
                      //   ),
                      //   content: Column(children: [
                      //     ...List.generate(record.length, (index) =>                           Padding(
                      //       padding: EdgeInsets.only(bottom: 10),
                      //       child: Container(
                      //         height: SizeConfig.heightMultiplier*5,
                      //         decoration: BoxDecoration(
                      //
                      //           gradient: LinearGradient(
                      //             colors: [
                      //               Color.fromRGBO(143, 148, 251, 1),
                      //               Color.fromRGBO(143, 148, 251, .6),
                      //             ],
                      //           ),
                      //           borderRadius: BorderRadius.circular(15),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: Color.fromRGBO(143, 148, 251, .2),
                      //               blurRadius: 20.0,
                      //               offset: Offset(0, 10),
                      //             )
                      //           ],
                      //         ),
                      //         child: Padding(
                      //           padding: EdgeInsets.symmetric(horizontal: 10),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text(dates[index],style: TextStyle(
                      //                   color: AppColors.textlight
                      //               ),),
                      //               Text(record[index],style: TextStyle(
                      //                   color: AppColors.textlight
                      //               ),),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     )
                      //   ],),
                      //   actions: [
                      //     CustomButton(callback: () {
                      //       Get.back();
                      //     },
                      //       height: SizeConfig.heightMultiplier*5,
                      //       width: SizeConfig.widthMultiplier*30,
                      //       title: "Ok",
                      //     )
                      //   ]
                      //
                      // );
                    },
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
                              style: TextStyle(
                                  color: Colors.black),
                            ),
                            Text(
                              leaves[index],
                              style: TextStyle(
                                  color: Colors.black),
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
                      onPressed: () => Navigator.pop(context, 'Cancel'),
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

