import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:hr_management_system/hr_modules/Leave%20Record%20Module/View/leave_data.dart';
import 'package:hr_management_system/hr_modules/Leave%20Record%20Module/view_model/leave_record_view_model.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';

import '../../../Utils/loading_indicator.dart';
import '../../../data_classes/constants.dart';

class LeaveRecord extends StatefulWidget {
  LeaveRecord({Key? key}) : super(key: key);

  @override
  State<LeaveRecord> createState() => _LeaveRecordState();
}

class _LeaveRecordState extends State<LeaveRecord> {
  final _controller = Get.put(LeaveRecordViewModel());
  @override
  void initState() {
    super.initState();
    _controller.loadUserID();
    _controller.loadLeaves();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
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
          flexibleSpace: const CustomAppbar(
            text: "Leave Record",
          ),
        ),
        body: _controller.isLoading.value
            ? Center(
                child: LoadingIndicator()
                    .loadingWithLabel(title: _controller.loadingString.value))
            : Container(
                // height: SizeConfig.heightMultiplier * 70,
                // width: 400,
                color: AppColors.background,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _controller.listLeavesCount.length,
                  itemBuilder: (BuildContext context, int index) {
                    var res = _controller.listLeavesCount[index];

                    return card(
                      () => Get.to(() => LeaveData(res.id!)),
                      res.name.toString(),
                      res.designation.toString(),
                      res.status.toString(),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

card(GestureTapCallback onPressed, String name, String designation,
    String leaves) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: InkWell(
      onTap: onPressed,
      // () {
      //   Navigator.push(context, CustomTransition(LeaveData()));
      // },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // width: SizeConfig.widthMultiplier*50,
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.white70,
              Colors.white70,
            ],
          ),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
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
              name,
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$designation",
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
                SizedBox(
                  width: 30,
                  child: Text(
                    leaves,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
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
