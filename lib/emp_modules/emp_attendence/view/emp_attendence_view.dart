import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/emp_modules/emp_attendence/view_model/emp_attendence_view_model.dart';

import '../../../Utils/colors.dart';
import '../../../Utils/custom_appbar.dart';
import '../../../Utils/loading_indicator.dart';
import '../../../Utils/size_config.dart';

class EMPAttendenceView extends StatefulWidget {
  const EMPAttendenceView({super.key});

  @override
  State<EMPAttendenceView> createState() => _EMPAttendenceViewState();
}

class _EMPAttendenceViewState extends State<EMPAttendenceView> {
  final _controller = Get.put(EMPAttendenceViewModel());

  @override
  void initState() {
    // TODO: implement initState
    _controller.loadUserID();
    _controller.loadLeaves();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
          text: "Attendence",
        ),
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? Center(child: LoadingIndicator().loadingWithLabel())
            : AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(width / 30),
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: _controller.dt.length,
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Total Presents: ${_controller.present.value}"),
                                  Text(
                                      "Total Absents: ${_controller.absent.value}"),
                                  Text(
                                      "Total Leaves: ${_controller.leave.value}"),
                                ],
                              ),
                              SizedBox(height: 10),
                              card(
                                index,
                                width,
                                _controller.dt[index].date.toString(),
                                _controller.dt[index].status!,
                              ),
                            ],
                          )
                        : card(
                            index,
                            width,
                            _controller.dt[index].date.toString(),
                            _controller.dt[index].status!,
                          );
                  },
                ),
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
