import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_management_system/Loan%20Module/Components/loan_components.dart';
import 'package:hr_management_system/Loan%20Module/model/loan_details_model.dart';
import 'package:hr_management_system/Loan%20Module/view_model/loan_view_model.dart';
import 'package:hr_management_system/Utils/app_message/toast_message.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/size_config.dart';

import '../../Utils/loading_indicator.dart';
import '../../data_classes/constants.dart';
import '../../data_classes/fcm_send.dart';

class LoanDetails extends StatelessWidget {
  bool ishr;
  final masterId;
  LoanDetails(this.masterId, {this.ishr = true, super.key});

  final _contrller = Get.find<LoanViewModel>();

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    _contrller.isLoadingAmount.value = true;

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
          text: "Loan Details",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: SizeConfig.heightMultiplier * 70,
            // margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier*5),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(AppConstants.loanDetailsCollectionName)
                  .where("master_loan_id", isEqualTo: masterId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: LoadingIndicator().loadingWithLabel());
                }
                final res = snapshot.data!.docs;
                _contrller.listLoanDetails.clear();
                for (var element in res) {
                  LoanDetailsModel amt = LoanDetailsModel.fromJson(
                      element.data() as Map<String, dynamic>);
                  _contrller.listLoanDetails.add(amt);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: res.length,
                  itemBuilder: (BuildContext context, int index) {
                    LoanDetailsModel loanDeatilsData =
                        LoanDetailsModel.fromJson(
                            res[index].data() as Map<String, dynamic>);
                    if (index == 0) {
                      Timer(Duration(seconds: 1), () {
                        _contrller.calculateAmount();
                      });
                    }
                    return LoanComponents().deatialCard(
                      isPaid: loanDeatilsData.isPaid,
                      amount: loanDeatilsData.amount,
                      title: loanDeatilsData.title,
                      updatedAt: loanDeatilsData.updatedAt == ""
                          ? DateTime.now().microsecondsSinceEpoch.toString()
                          : loanDeatilsData.updatedAt,
                      onPressed: !ishr
                          ? null
                          : () {
                              ToastMessage().defaultYesNoDialouge(
                                "Is ${loanDeatilsData.title} is paid?",
                                yesText: "Yes",
                                noText: "No",
                                onCancelPressed: () async {
                                  await _contrller
                                      .unPaidInstallment(loanDeatilsData.id!);
                                  FCM().send(
                                    title: "Loan",
                                    message:
                                        "Installment of Rs. ${loanDeatilsData.amount} is not paid yet.",
                                    collectionName:
                                        AppConstants.employesCollectionName,
                                    docId: _contrller.userId.value,
                                  );
                                  if (Get.isDialogOpen == true) {
                                    Get.back();
                                  }
                                },
                                onConfirmPressed: () async {
                                  await _contrller
                                      .paidInstallment(loanDeatilsData.id!);
                                  FCM().send(
                                    title: "Loan",
                                    message:
                                        "Installment of Rs. ${loanDeatilsData.amount} is paid",
                                    collectionName:
                                        AppConstants.employesCollectionName,
                                    docId: _contrller.userId.value,
                                  );
                                  if (Get.isDialogOpen == true) {
                                    Get.back();
                                  }
                                },
                              );
                            },
                    );
                  },
                );
              },
            ),
          ),
          Obx(
            () => _contrller.isLoadingAmount.value
                ? LoadingIndicator().loadingWithLabel()
                : LoanComponents().loanMasterDetailCard(
                    paidAmount: _contrller.paidAmount.value.toString(),
                    rmainingAmount: (_contrller.totalAmount.value -
                            _contrller.paidAmount.value)
                        .toString(),
                    totalAmount: _contrller.totalAmount.value.toString(),
                  ),
          ),
        ],
      ),
    );
  }
}
