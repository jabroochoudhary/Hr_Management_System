import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/custom_appbar.dart';

class EMPAttendenceView extends StatelessWidget {
  const EMPAttendenceView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Container(),
    );
  }
}
