// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_management_system/Loan%20Module/Components/loan_components.dart';
import 'package:hr_management_system/Loan%20Module/View/loan_details.dart';
import 'package:hr_management_system/Loan%20Module/model/loan_master_model.dart';
import 'package:hr_management_system/Loan%20Module/view_model/loan_view_model.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/loading_indicator.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';

import '../../Utils/app_message/toast_message.dart';

class LoanRecord extends StatelessWidget {
  bool isHr;
  LoanRecord({this.isHr = true, Key? key}) : super(key: key);
  final _controller = Get.put(LoanViewModel());
  @override
  Widget build(BuildContext context) {
    _controller.loadUserId();
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
            text: "Loan Record",
          ),
        ),
        body: StreamBuilder(
          stream: !isHr
              ? FirebaseFirestore.instance
                  .collection(AppConstants.loanMasterCollectionName)
                  .where("emp_id", isEqualTo: _controller.userId.value)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection(AppConstants.loanMasterCollectionName)
                  .where("hr_id", isEqualTo: _controller.userId.value)
                  .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LoadingIndicator().loadingWithLabel());
            }
            final res = snapshot.data!.docs;

            return ListView.builder(
              itemCount: res.length,
              itemBuilder: (BuildContext context, int index) {
                LoanMasterModel loanMasterData = LoanMasterModel.fromJson(
                    res[res.length - index - 1].data() as Map<String, dynamic>);

                return FutureBuilder<AddEmployeeModel>(
                  future: _controller.loadUserCloudData(
                      uid: loanMasterData.empId.toString()),
                  builder: (BuildContext context, userSnapshot) {
                    // final empData = AddEmployeeModel.fromJson(
                    //     userSnapshot.data as Map<String, dynamic>);
                    try {
                      return LoanComponents().recordCard(
                        context,
                        amount: loanMasterData.totalLoan,
                        name: userSnapshot.data!.name,
                        designation: userSnapshot.data!.designation,
                        createdAt: loanMasterData.createdAt,
                        onLongPressed: () async {
                          await ToastMessage().defaultYesNoDialouge(
                              "Are you sure to delete the Loan record of ''${userSnapshot.data!.name}''. Changes in database is permanent.",
                              onConfirmPressed: () {
                            _controller
                                .deleteEmployeeLoanRecord(loanMasterData.id!);
                            Get.back();
                            // _controller.listOfVoices
                            //     .removeAt(index);
                          }, onCancelPressed: () {
                            Get.back();
                          });
                        },
                        onPressed: () {
                          Get.to(() => LoanDetails(
                                loanMasterData.id,
                                ishr: isHr,
                              ));
                        },
                      );
                    } catch (e) {
                      return Center(
                          child: LoadingIndicator().loadingWithLabel());
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
