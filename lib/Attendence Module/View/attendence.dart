// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:hr_management_system/Attendence%20Module/Components/attendence_color.dart';
import 'package:hr_management_system/Attendence%20Module/Components/names.dart';
import 'package:hr_management_system/Attendence%20Module/Components/user_prefrences.dart';
import 'package:hr_management_system/Attendence%20Module/view_model/attendence_view_model.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/loading_indicator.dart';
import 'package:hr_management_system/Utils/pop_up_notification.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/data_classes/constants.dart';

class AttendencePage extends StatefulWidget {
  const AttendencePage({Key? key}) : super(key: key);

  @override
  _AttendencePageState createState() => _AttendencePageState();
}

class _AttendencePageState extends State<AttendencePage> {
  final studentvar = UserPrefrences.studentlist;

  final _controllerAttendence = Get.put(AttendenceViewModel());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerAttendence.loadUserID();
  }

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
      body: Column(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          const Center(
            child: Text(
              "Select those who are present ands \n     long press for more options",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: SizeConfig.heightMultiplier * 65,
            width: 400,
            color: AppColors.background,

            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(AppConstants.employesCollectionName)
                  .where(_controllerAttendence.hr_id.value)
                  .snapshots(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.docs.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final res = snapshot.data!.docs[index];
                            final employee = AddEmployeeModel.fromJson(
                                res.data() as Map<String, dynamic>);

                            return buildAttendenceCard(
                                context, index, employee);
                          },
                        )
                      : Center(child: LoadingIndicator().loading());
                } else {
                  return Center(
                    child: Text("Here is no eployee to show for attendece"),
                  );
                }
              }),
            ),

            // child: ListView.builder(
            //     physics: BouncingScrollPhysics(),
            //     itemCount: studentvar.length,
            //     itemBuilder: (BuildContext context, int index) =>
            //         buildAttendenceCard(context, index),
            //         ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            callback: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Submit Attendence?'),
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

  buildAttendenceCard(BuildContext context, int index, AddEmployeeModel data) {
    var index2 = index + 1;

    return FocusedMenuHolder(
      menuWidth: SizeConfig.widthMultiplier * 75,
      duration: Duration(milliseconds: 250),
      animateMenuItems: true,
      onPressed: () {
        setState(() {
          ChangeState(isSelectedList, index, 1);
          ChangeColor(isSelectedList, index);
        });
        // Navigator.of(this.context).push(
        // MaterialPageRoute(builder: (context) => ProfilePage()),
        // );
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
              setState(() {
                ChangeState(isSelectedList, index, 1);
                ChangeColor(isSelectedList, index);
              });
              // Navigator.of(this.context).push(
              //   MaterialPageRoute(builder: (context) => ProfilePage()),
              // );
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
              setState(() {
                ChangeState(isSelectedList, index, 0);
                ChangeColor(isSelectedList, index);
              });
              // Navigator.of(this.context).push(
              //   MaterialPageRoute(builder: (context) => EditProfilePage()),
              // );
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
              setState(() {
                ChangeState(isSelectedList, index, 2);
                ChangeColor(isSelectedList, index);
              });
              // Navigator.of(this.context).push(
              //   MaterialPageRoute(builder: (context) => ChangePassword()),
              // );
            },
            backgroundColor: Colors.yellow),
      ],
      child: Container(
        child: Card(
          color: attendencecolor[index],
          elevation: 2,
          shadowColor: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Text(
                  index2.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  data.name.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Text(
                  data.expertise.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void ChangeState(List<int> isSelectedList, int value, int i) {
    isSelectedList[value] = i;
  }

  void ResetState() {
    for (int state = 0; state < attendencecolor.length; state++) {
      attendencecolor[state] = Colors.white;
    }
  }

  void ChangeColor(List<int> isSelectedList, int index) {
    if (isSelectedList[index] == 1) {
      attendencecolor[index] = green;
      // print("changed to : "+ isSelectedList.toString());
    } else {
      if (isSelectedList[index] == 2) {
        attendencecolor[index] = yellow;
        // print("changed to : "+ isSelectedList.toString());
      } else {
        attendencecolor[index] = red;
        // print("changed to : "+ isSelectedList.toString());
      }
    }
  }
}
