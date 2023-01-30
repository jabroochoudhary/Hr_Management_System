import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class LeaveData extends StatelessWidget {
  List dates =[
    "13/07/2022",
    "18/07/2022",
    "18/07/2022",
    "18/07/2022",
    "18/07/2022",
    "18/07/2022",
    "05/08/2022",
    "10/08/2022",
  ];
  List record =[
    "Leave",
    "Absent",
    "Absent",
    "Absent",
    "Leave",
    "Leave",
    "Leave",
    "Absent",
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
        body: AnimationLimiter(
            child: ListView.builder(
              padding: EdgeInsets.all(width / 30),
              physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: dates.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    verticalOffset: -250,
                    child: ScaleAnimation(
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Container(
                        margin: EdgeInsets.only(bottom: width / 20),
                        height: SizeConfig.heightMultiplier*10,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white70,
                              Colors.white70,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date",style: TextStyle(
                                  color: AppColors.coloredtext,
                                  fontSize: 16

                              ),),
                              Text("Status",style: TextStyle(
                                  color: AppColors.coloredtext,
                                  fontSize: 16

                              ),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(dates[index],style: TextStyle(
                                  color: AppColors.textlight,
                                  fontSize: 16
                              ),),
                              Text(record[index],style: TextStyle(
                                  color: AppColors.textlight,
                                  fontSize: 16

                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ),
        );
    }
}