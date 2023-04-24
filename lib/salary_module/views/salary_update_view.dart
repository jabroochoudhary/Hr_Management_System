import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/app_message/toast_message.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/salary_module/components/salary_components.dart';
import 'package:hr_management_system/salary_module/model/salary_model.dart';
import 'package:hr_management_system/salary_module/view_model/salary_view_model.dart';
import 'package:intl/intl.dart';
import '../../Utils/custom_appbar.dart';
import '../../Utils/loading_indicator.dart';
import '../../data_classes/constants.dart';

class SalaryUpdateView extends StatelessWidget {
  String masterId;

  SalaryUpdateView({required this.masterId, super.key});
  final _controller = Get.find<SalaryViewModel>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.fromMicrosecondsSinceEpoch(int.parse(masterId));
    String formattedDate = DateFormat('MMMM, yyyy').format(now);
    final label = formattedDate;
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
          text: label,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(AppConstants.salarydeatailCollectionName)
            .where("master_id", isEqualTo: masterId)
            .snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: LoadingIndicator().loading());
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                // itemCount: 30,
                itemBuilder: (context, index) {
                  final res = snapshot.data!.docs[index];

                  ////////////////
                  final detailSalaryData = DetailsSalaryModel.fromJson(
                      res.data() as Map<String, dynamic>);
                  DateTime now = DateTime.fromMicrosecondsSinceEpoch(
                      int.parse(detailSalaryData.createdAt.toString()));
                  String fdate = DateFormat('MMMM, yyyy').format(now);
                  return SalaryComponents().salaryCard(
                    dt: detailSalaryData,
                    longPressed: () async {
                      _controller.showEmpProfile(docId: detailSalaryData.empId);
                    },
                    onPressed: () {
                      ToastMessage().defaultYesNoDialouge(
                        "Is you pay Rs. ${detailSalaryData.salary} to ${detailSalaryData.empName} of $label.",
                        noText: "NO",
                        yesText: "Yes",
                        onCancelPressed: () {
                          _controller.salaryPayStatus(
                              detailSalaryData.id.toString(),
                              false,
                              detailSalaryData.empId.toString());
                          Get.back();
                        },
                        onConfirmPressed: () {
                          _controller.salaryPayStatus(
                              detailSalaryData.id.toString(),
                              true,
                              detailSalaryData.empId.toString());
                          Get.back();
                        },
                      );
                    },
                  );
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
    );
  }
}
