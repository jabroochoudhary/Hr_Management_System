import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/hr_modules/Attendence%20Module/view_model/attendence_view_model.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../../../Utils/app_message/toast_message.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/custom_appbar.dart';
import '../../../Utils/loading_indicator.dart';
import '../../../Utils/size_config.dart';
import '../../../data_classes/constants.dart';
import 'attendence.dart';

class DatesListView extends StatefulWidget {
  DatesListView({super.key});

  @override
  State<DatesListView> createState() => _DatesListViewState();
}

class _DatesListViewState extends State<DatesListView> {
  final _controller = Get.put(AttendenceViewModel());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.loadUserID();
    _controller.chekDocIsExsist();
  }

  DateTime selectedDate = DateTime.now();
  String card2value = "Select Date";
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
          text: "Select Date",
        ),
      ),
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Obx(
            () => Column(
              children: [
                card(
                  "Today",
                  onPressed: () async {
                    final progress = ProgressHUD.of(context);

                    progress?.showWithText('Loading...');
                    await _controller.setTodayAttandenceSheet(dateT: null);
                    progress?.dismiss();
                  },
                ),
                card(
                  card2value,
                  longPressed: () {
                    final progress = ProgressHUD.of(context);

                    progress?.showWithText("Loading...");

                    _controller.setTodayAttandenceSheet(dateT: selectedDate);
                    progress?.dismiss();
                  },
                  onPressed: () {
                    // _controller.getDatesCollectionNames();
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(2015, 1, 1),
                      maxTime: DateTime.now(),
                      theme: const DatePickerTheme(
                        cancelStyle: TextStyle(
                            color: AppColors.textlight,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                        doneStyle: TextStyle(
                            color: AppColors.coloredtext,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                      onChanged: (date) {
                        // _controllerAddEmployee.joiningDateController.value.text =
                        //     "${date.day}-${date.month}-${date.year}";
                        selectedDate = date;
                      },
                      onConfirm: (date) {
                        // print("${date.day}-${date.month}-${date.year}");
                        setState(() {
                          card2value =
                              "Selected Date: ${date.day}-${date.month}-${date.year}";
                          selectedDate = date;
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                ),
                !_controller.isHistoryHas.value
                    ? Center(child: Text("No Attandence history"))
                    : Container(
                        height: SizeConfig.heightMultiplier * 70,
                        width: 400,
                        color: AppColors.background,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(AppConstants.hrAttandenceCollection)
                              .doc(_controller.hr_id.value)
                              .collection(
                                  AppConstants.datesCollectionInHrAttandence)
                              .orderBy("created_at", descending: true)
                              .snapshots(),
                          builder: ((context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                    child: Text("No Attandence history"));
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  // itemCount: 30,
                                  itemBuilder: (context, index) {
                                    final res = snapshot.data!.docs[index];

                                    return Dismissible(
                                        key: UniqueKey(),
                                        onDismissed: (direction) {
                                          _controller
                                              .deleteAttandence(res['id']);
                                        },
                                        confirmDismiss: (direction) async {
                                          bool val = false;

                                          await ToastMessage().defaultYesNoDialouge(
                                              "Are you sure to delete attandence of ${res['id']}. Changes in database is permanent.",
                                              onConfirmPressed: () {
                                            val = true;
                                            Get.back();
                                            // _controller.listOfVoices
                                            //     .removeAt(index);
                                          }, onCancelPressed: () {
                                            val = false;
                                            Get.back();
                                          });
                                          return val;
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: const Center(
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                        child: card(
                                          "Date: ${res['id']}",
                                          onPressed: () {
                                            Get.to(() => AttendencePage(),
                                                arguments: {"date": res['id']});
                                          },
                                        ));
                                  },
                                );
                              }
                            } else {
                              return Center(
                                child: LoadingIndicator().loading(),
                              );
                            }
                          }),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  card(String text,
      {GestureTapCallback? onPressed, GestureLongPressCallback? longPressed}) {
    return InkWell(
      onTap: onPressed,
      onLongPress: longPressed,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 22,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
