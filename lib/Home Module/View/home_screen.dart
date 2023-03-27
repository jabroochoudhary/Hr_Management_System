import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Loan%20Module/View/loan_record.dart';
import 'package:hr_management_system/emp_modules/emp_attendence/view/emp_attendence_view.dart';
import 'package:hr_management_system/hr_modules/Attendence%20Module/View/dates_list.dart';
import 'package:hr_management_system/Home%20Module/Components/drawer.dart';
import 'package:hr_management_system/Home%20Module/Components/searchform.dart';
import 'package:hr_management_system/hr_modules/Leave%20Record%20Module/View/leave_record.dart';
import 'package:hr_management_system/Loan%20Module/View/get_loan_view.dart';
import 'package:hr_management_system/Login%20Module/View/login_screen.dart';
import 'package:hr_management_system/Report%20Module/View/report_screen.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/view/add_employee.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/notification_module/views/notification_view.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  bool isHr;
  HomeScreen(
    this.isHr, {
    Key? key,
  }) : super(key: key);

  // int selectedcontainer=0;
  List hrCaption = [
    "Attendence",
    "Leave Record",
    "Loan Record",
    "Add Employee",
    "Reports",
    "Logout",
  ];

  List hrLogo = [
    "assets/attendence.json",
    "assets/leave.json",
    "assets/loan.json",
    "assets/add_employee.json",
    "assets/report.json",
    "assets/logout.json",
  ];

  List<dynamic> hrPages = [
    DatesListView(),
    LeaveRecord(),
    LoanRecord(),
    SignupScreen(),
    ReportScreen(),
    LoginScreen(),
  ];

///////////////////////////////////////
  List empCaption = [
    "Attendence",
    "Loan",
    "Reports",
    "Logout",
  ];

  List empLogo = [
    "assets/attendence.json",
    "assets/loan.json",
    "assets/report.json",
    "assets/logout.json",
  ];

  List<dynamic> empPages = [
    EMPAttendenceView(),
    GetLoanView(),
    ReportScreen(),
    LoginScreen(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldkey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                  onTap: () => Get.to(() => NotificationView()),
                  child: Icon(Icons.notifications_none)),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              )
            ],
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        // bottomOpacity: 0,
        elevation: 0,
        flexibleSpace: const CustomAppbar(
          text: "Home Screen",
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              // SizedBox(
              //   height: SizeConfig.heightMultiplier * 3,
              // ),
              // SearchField(),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 25.0,
                ),
                itemCount: isHr ? hrCaption.length : empCaption.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () =>
                        Get.to(isHr ? hrPages[index] : empPages[index]),
                    child: Container(
                      // padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 17,
                            child: Lottie.asset(
                                isHr ? hrLogo[index] : empLogo[index]),
                          ),
                          Text(
                            isHr ? hrCaption[index] : empCaption[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Container(
      //       height: 65,
      //       width: 65,
      //       decoration:
      //           BoxDecoration(shape: BoxShape.circle, color: Color(0xffB2C6FE)
      //               // gradient: LinearGradient(
      //               //   colors: [
      //               //     Color.fromRGBO(143, 148, 251, 1),
      //               //     Color.fromRGBO(143, 148, 251, .6),
      //               //   ],
      //               // ),
      //               ),
      //       child: Lottie.asset("assets/action.json", fit: BoxFit.fitWidth)),
      // ),
    );
  }
}
