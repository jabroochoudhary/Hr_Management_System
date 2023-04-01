import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Utils/colors.dart';
import '../../Utils/custom_appbar.dart';
import '../../Utils/loading_indicator.dart';
import '../../data_classes/constants.dart';
import '../components/salary_components.dart';
import '../model/salary_model.dart';

class EmpSideSalaryView extends StatelessWidget {
  String empDocId;
  EmpSideSalaryView({required this.empDocId, super.key});

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
          text: "Salary",
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(AppConstants.salarydeatailCollectionName)
            .where("emp_id", isEqualTo: empDocId)
            .snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Text("Salary history not available.");
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
                  return SalaryComponents()
                      .empSalaryCard(dt: detailSalaryData, formatedDtae: fdate);
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
