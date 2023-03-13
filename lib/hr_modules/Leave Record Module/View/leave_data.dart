import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hr_management_system/hr_modules/Leave%20Record%20Module/view_model/leave_record_view_model.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class LeaveData extends StatelessWidget {
  final _controller = Get.find<LeaveRecordViewModel>();
  String userId;
  LeaveData(this.userId);

  @override
  Widget build(BuildContext context) {
    var dt = <LeavesModel>[];
    int present = 0;
    int absent = 0;
    int leave = 0;

    double width = MediaQuery.of(context).size.width;
    for (var element in _controller.listLeavesModel) {
      if (element.id.toString() == userId) {
        dt.add(element);
        element.status == 0
            ? absent += 1
            : element.status == 1
                ? present += 1
                : element.status == 2
                    ? leave += 1
                    : 8;
      }
    }
    // print(userId.toString());
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
          itemCount: dt.length,
          itemBuilder: (BuildContext context, int index) {
            return index == 0
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Presents: $present"),
                          Text("Total Absents: $absent"),
                          Text("Total Leaves: $leave"),
                        ],
                      ),
                      SizedBox(height: 10),
                      card(
                        index,
                        width,
                        dt[index].date.toString(),
                        dt[index].status!,
                      ),
                    ],
                  )
                : card(
                    index,
                    width,
                    dt[index].date.toString(),
                    dt[index].status!,
                  );
          },
        ),
      ),
    );
  }

  card(
    int index,
    double width,
    String date,
    int status,
  ) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 50),
      child: SlideAnimation(
        duration: const Duration(milliseconds: 2000),
        curve: Curves.fastLinearToSlowEaseIn,
        verticalOffset: -250,
        child: ScaleAnimation(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Container(
            margin: EdgeInsets.only(bottom: width / 20),
            height: SizeConfig.heightMultiplier * 10,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white70,
                  Colors.white70,
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
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
                    children: const [
                      Text(
                        "Date",
                        style: TextStyle(
                            color: AppColors.coloredtext, fontSize: 18),
                      ),
                      Text(
                        "Status",
                        style: TextStyle(
                            color: AppColors.coloredtext, fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                            color: AppColors.textlight, fontSize: 18),
                      ),
                      Text(
                        status == 0
                            ? "Absent"
                            : status == 1
                                ? "Present"
                                : status == 2
                                    ? "Leave"
                                    : "No Record",
                        style: TextStyle(
                            color: status == 0
                                ? Colors.red
                                : status == 1
                                    ? Colors.green
                                    : status == 2
                                        ? Colors.orange
                                        : Colors.grey,
                            fontSize: 18),
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
  }
}
