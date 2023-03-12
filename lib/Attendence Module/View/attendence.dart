// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:hr_management_system/Attendence%20Module/attandence_model/attandence_model.dart';

import 'package:hr_management_system/Attendence%20Module/view_model/attendence_view_model.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/loading_indicator.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/data_classes/constants.dart';

class AttendencePage extends StatefulWidget {
  const AttendencePage({Key? key}) : super(key: key);

  @override
  _AttendencePageState createState() => _AttendencePageState();
}

class _AttendencePageState extends State<AttendencePage> {
  // final studentvar = UserPrefrences.studentlist;

  final _controllerAttendence = Get.find<AttendenceViewModel>();
  String date = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerAttendence.loadUserID();
    final args = Get.arguments;

    date = args['date'].toString();
  }

  int aten = 0;
  List<int> listAtten = [];

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
        flexibleSpace: const CustomAppbar(
          text: "Attendence",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 5),
        color: AppColors.background,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(AppConstants.hrAttandenceCollection)
              .doc(_controllerAttendence.hr_id.value)
              .collection(AppConstants.datesCollectionInHrAttandence)
              .doc(date)
              .collection(
                  AppConstants.attendenceInDatesCollectionInHrAttandence)
              .snapshots(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.docs.isNotEmpty
                  ? ListView.builder(
                      // reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final res = snapshot.data!.docs[index];
                        listAtten.add(0);
                        final employee = AttandenceModel.fromJson(
                            res.data() as Map<String, dynamic>);

                        return buildAttendenceCard(context, index, employee);
                      },
                    )
                  : Center(child: LoadingIndicator().loading());
            } else {
              return const Center(
                child: Text("No eployee for attendece"),
              );
            }
          }),
        ),
      ),
    );
  }

  buildAttendenceCard(
      BuildContext context, int index, AttandenceModel dataAtt) {
    return FocusedMenuHolder(
      menuWidth: SizeConfig.widthMultiplier * 75,
      duration: Duration(milliseconds: 250),
      animateMenuItems: true,
      onPressed: () {
        _controllerAttendence.updateAttandenceStatus(
            dataAtt.empId.toString(), 1, date);
      },
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
            title: const Text(
              "Present",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            onPressed: () {
              _controllerAttendence.updateAttandenceStatus(
                  dataAtt.empId.toString(), 1, date);
            },
            backgroundColor: Colors.green),
        //00CE2D
        FocusedMenuItem(
            title: const Text(
              "Absent",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            onPressed: () {
              _controllerAttendence.updateAttandenceStatus(
                  dataAtt.empId.toString(), 0, date);
            },
            backgroundColor: Colors.red),
        FocusedMenuItem(
            title: const Text(
              "Leave",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _controllerAttendence.updateAttandenceStatus(
                  dataAtt.empId.toString(), 2, date);
            },
            backgroundColor: Colors.yellow),
      ],
      child: Container(
        child: Card(
          // color: attendencecolor[index],
          color: dataAtt.status == 0
              ? Colors.red
              : dataAtt.status == 1
                  ? Colors.green
                  : dataAtt.status == 2
                      ? Colors.yellow
                      : Colors.white,
          elevation: 2,
          shadowColor: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Text(
                  (index + 1).toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  dataAtt.name.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Text(
                  dataAtt.designation.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
