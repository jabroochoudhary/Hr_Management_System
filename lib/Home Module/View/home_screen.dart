import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_management_system/Loan%20Module/View/loan_record.dart';
import 'package:hr_management_system/Report%20Module/view/emp_report_view.dart';
import 'package:hr_management_system/data_classes/fcm_send.dart';
import 'package:hr_management_system/emp_modules/emp_attendence/view/emp_attendence_view.dart';
import 'package:hr_management_system/hr_modules/Attendence%20Module/Components/attendence_color.dart';
import 'package:hr_management_system/hr_modules/Attendence%20Module/View/dates_list.dart';
import 'package:hr_management_system/Home%20Module/Components/drawer.dart';
import 'package:hr_management_system/hr_modules/Leave%20Record%20Module/View/leave_record.dart';
import 'package:hr_management_system/Loan%20Module/View/get_loan_view.dart';
import 'package:hr_management_system/Login%20Module/View/login_screen.dart';
import 'package:hr_management_system/Report%20Module/view/report_screen.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/view/add_employee.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/hr_modules/employees_list/views/employees_list_view.dart';
import 'package:hr_management_system/hr_modules/hr_profile/views/hr_profile_view.dart';
import 'package:hr_management_system/notification_module/views/notification_view.dart';
import 'package:hr_management_system/profile/view_model/profile_view_model.dart';
import 'package:hr_management_system/salary_module/views/emp_side_salary_view.dart';
import 'package:hr_management_system/salary_module/views/salary_view.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  bool isHr;
  HomeScreen(
    this.isHr, {
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    EmployeeReportView(),
    LoginScreen(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _profileController = Get.put(ProfileViewModel());
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    requestPermission();
    loadFcm();
    listenFcm();
    // listenFcm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _profileController.loadUserCloudData();
    return Obx(
      () => Scaffold(
        key: _scaffoldkey,
        drawer: widget.isHr
            ? MyDrawer(
                email: _profileController.email.value,
                imgUrl: _profileController.imageUrl.value,
                name: _profileController.name.value,
                cName: _profileController.companyName.value,
                profilePressed: () {
                  Get.to(
                      () => HRProfileView(hrData: _profileController.hrData!));
                },
                employeesPressed: () => Get.to(() => EmployeesListView()),
                salaryPressed: () => Get.to(() => SalaryView()),
              )
            : MyEmpDrawer(
                email: _profileController.email.value,
                imgUrl: _profileController.imageUrl.value,
                name: _profileController.name.value,
                editPressed: () async {
                  await Get.to(SignupScreen(
                    empData: _profileController.empData,
                  ));
                  _profileController.loadUserCloudData();
                },
                salaryPressed: () => Get.to(() => EmpSideSalaryView(
                    empDocId: _profileController.empData!.id.toString())),
              ),
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
                  itemCount: widget.isHr ? hrCaption.length : empCaption.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (widget.isHr && index == 5) {
                          Get.offAll(() => LoginScreen());
                        } else if (index == 4) {
                          Get.to(() => ReportScreen());
                        } else if (!widget.isHr && index == 3) {
                          Get.offAll(() => LoginScreen());
                        } else {
                          Get.to(
                              widget.isHr ? hrPages[index] : empPages[index]);
                        }
                      },
                      child: Container(
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
                                  widget.isHr ? hrLogo[index] : empLogo[index]),
                            ),
                            Text(
                              widget.isHr
                                  ? hrCaption[index]
                                  : empCaption[index],
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
      ),
    );
  }

  ////////////// FCM token Code
  ///
  void listenFcm() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        try {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                playSound: true,
                color: primaryColor,

                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        } catch (e) {
          print("Error Listen FCM");
          print(e.toString());
        }
      }
    });
    // FirebaseMessaging.onBackgroundMessage((message) async {});
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!\nm\nh\ng\n');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        Get.to(() => NotificationView());
      }
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted pervisional permission");
    } else {
      print("User undeclined permission");
    }
  }

  void loadFcm() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
        enableLights: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
}
