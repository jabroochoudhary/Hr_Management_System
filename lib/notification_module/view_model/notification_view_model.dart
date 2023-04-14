import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Loan%20Module/model/loan_details_model.dart';
import 'package:hr_management_system/Loan%20Module/model/loan_master_model.dart';
import 'package:hr_management_system/Utils/pop_up_notification.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/notification_module/model/notification_model.dart';

import '../../data_classes/local_data_saver.dart';

class NotificationViewModel extends GetxController {
  final userId = "".obs;
  RxBool isLoading = false.obs;
  final rejectionController = TextEditingController().obs;
  RxBool isHr = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadUserData();
  }

  loadUserData() async {
    userId.value =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
    isHr.value =
        (await AppLocalDataSaver.getBool(AppLocalDataSaver.isHRLoginKey))!;
    // print(userId.value);
  }

  markedAsRead(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.notificationCollectionName)
          .doc(id)
          .update({"isActive": false});
    } catch (e) {}
  }

  markedAsUnRead(String id) async {
    await FirebaseFirestore.instance
        .collection(AppConstants.notificationCollectionName)
        .doc(id)
        .update({"isActive": true});
  }

  rejectLoanRequest(NotificationModel data) async {
    final message = data.message;

    RegExp regex = RegExp(r'Request loan of Rs. (\d+) in (\d+) installments.');

    // Extract the amount and installment number from the message string
    RegExpMatch? match = regex.firstMatch(message!);
    String? amount = match?.group(1);
    String? installments = match?.group(2);

    if (rejectionController.value.text.isNotEmpty) {
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final name =
          await AppLocalDataSaver.getString(AppLocalDataSaver.userName);
      final notify = NotificationModel(
        id: id,
        receiverId: data.senderId,
        senderId: data.receiverId,
        senderName: name,
        title: "Loan Rejected",
        designation: "Hr",
        isActive: true,
        message:
            "Your request for loan of Rs. $amount is rejected. ${rejectionController.value.text}",
      );
      await FirebaseFirestore.instance
          .collection(AppConstants.notificationCollectionName)
          .doc(id)
          .set(notify.toJson());
      Get.back();
      FirebaseFirestore.instance
          .collection(AppConstants.notificationCollectionName)
          .doc(data.id)
          .delete();
    } else {
      PopUpNotification()
          .show("Please enter proper reason of rejection.", "Alert");
    }
  }

  acceptLoanRequest(NotificationModel data) async {
    isLoading.value = true;
    final message = data.message;

    RegExp regex = RegExp(r'Request loan of Rs. (\d+) in (\d+) installments.');

    // Extract the amount and installment number from the message string
    RegExpMatch? match = regex.firstMatch(message!);
    String? amount = match?.group(1);
    String? installments = match?.group(2);
    if (int.parse(installments!) > 10) {
      PopUpNotification()
          .show("Loan installments not be more then 10.", "Alert");
      isLoading.value = false;
      return;
    }

    final masterId = DateTime.now().microsecondsSinceEpoch.toString();

    final loanMasterData = LoanMasterModel(
      createdAt: masterId,
      empId: data.senderId,
      hrId: data.receiverId,
      id: masterId,
      installments: installments,
      totalLoan: amount,
    );
    await FirebaseFirestore.instance
        .collection(AppConstants.loanMasterCollectionName)
        .doc(masterId)
        .set(loanMasterData.toJson());

    final oneInstallmentAMount = int.parse(amount!) / int.parse(installments);

    for (int i = 0; i < int.parse(installments); i++) {
      final dtId = DateTime.now().microsecondsSinceEpoch.toString();

      final loanDetailsData = LoanDetailsModel(
        amount: oneInstallmentAMount.toString(),
        ceatedAt: dtId,
        id: dtId,
        isPaid: false,
        masterLoanId: masterId,
        title: "Installment ${i + 1}",
        updatedAt: "",
      );

      await FirebaseFirestore.instance
          .collection(AppConstants.loanDetailsCollectionName)
          .doc(dtId)
          .set(loanDetailsData.toJson());
    }
    final hrName =
        await AppLocalDataSaver.getString(AppLocalDataSaver.userName);
    final notifyId = DateTime.now().microsecondsSinceEpoch.toString();
    final notify = NotificationModel(
      designation: "HR",
      id: notifyId,
      isActive: true,
      message:
          "Your request for Loan is accepted. Check Loan Record for details.",
      receiverId: data.senderId,
      senderId: data.receiverId,
      senderName: hrName,
      title: "Loan Accepted",
    );
    await FirebaseFirestore.instance
        .collection(AppConstants.notificationCollectionName)
        .doc(notifyId)
        .set(notify.toJson());
    isLoading.value = false;
    print("accept done");
    Get.back();
    Get.back();
    PopUpNotification().show(
        "Loan record is sucessfully set. Check Loan details in Loan Record.",
        "Sucess");
    FirebaseFirestore.instance
        .collection(AppConstants.notificationCollectionName)
        .doc(data.id)
        .delete();
  }
}
