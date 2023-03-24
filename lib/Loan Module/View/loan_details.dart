import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class LoanDetails extends StatelessWidget {
  List dates = [
    "13/07/2022",
    "18/07/2022",
    "18/07/2022",
    "18/07/2022",
    "18/07/2022",
    "18/07/2022",
    "05/08/2022",
    "10/08/2022",
  ];
  List record = [
    "10,000",
    "5,000",
    "10,000",
    "20,000",
    "20,000",
    "20,000",
    "5,000",
    "5,000",
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
          text: "Loan Details",
        ),
      ),
      body: Column(
        children: [
          Container(
            height: SizeConfig.heightMultiplier * 70,
            // margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier*5),
            child: AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(width / 30),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
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
                          height: SizeConfig.heightMultiplier * 12.5,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Installment $index",
                                      style: TextStyle(
                                          color: AppColors.coloredtext,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      dates[index],
                                      style: TextStyle(
                                          color: AppColors.textlight,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      record[index],
                                      style: TextStyle(
                                          color: AppColors.textlight,
                                          fontSize: 16),
                                    ),
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
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            height: SizeConfig.heightMultiplier * 12,
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
                      Text(
                        "Total Loan",
                        style: TextStyle(
                            color: AppColors.coloredtext,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "50,000",
                        style:
                            TextStyle(color: AppColors.textlight, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Paid Loan",
                        style: TextStyle(
                            color: AppColors.coloredtext,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "30,000",
                        style:
                            TextStyle(color: AppColors.textlight, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remaining Loan",
                        style: TextStyle(
                            color: AppColors.coloredtext,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "20,000",
                        style:
                            TextStyle(color: AppColors.textlight, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
